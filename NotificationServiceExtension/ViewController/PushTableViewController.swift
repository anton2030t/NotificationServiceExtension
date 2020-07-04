//
//  PushTableViewController.swift
//  NotificationServiceExtension
//
//  Created by Anton Larchenko on 30.06.2020.
//  Copyright © 2020 Anton Larchenko. All rights reserved.
//

import UIKit
import SafariServices

class PushTableViewController: UITableViewController {
    
    static let refreshPushNotification = Notification.Name(rawValue: "refreshPushNotification")
    let pushStore = PushStore.shared
    
    private var tokenButton: UIButton?
    private static let buttonHeight: CGFloat = 50
    private static let buttonWidth: CGFloat = 50
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(PushTableViewController.receivedRefreshPushNotification(_:)),
            name: PushTableViewController.refreshPushNotification,
            object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func receivedRefreshPushNotification(_ notification: Notification) {
        DispatchQueue.main.async {
            self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createTokenButton()
    }

    public override func viewWillDisappear(_ animated: Bool) {
        guard tokenButton?.superview != nil else { return }
        DispatchQueue.main.async {
            self.tokenButton?.removeFromSuperview()
            self.tokenButton = nil
        }
        super.viewWillDisappear(animated)
    }

    private func createTokenButton() {
        tokenButton = UIButton(type: .custom)
        tokenButton?.translatesAutoresizingMaskIntoConstraints = false
        tokenButton?.backgroundColor = .black
        tokenButton?.setImage(UIImage(named: "icon"), for: .normal)
        tokenButton?.layer.cornerRadius = PushTableViewController.buttonHeight/2
        tokenButton?.addTarget(self, action: #selector(doThisWhenButtonIsTapped(_:)), for: .touchUpInside)
        constrainTokenButtonToWindow()
        addShadowToTokenButton()
        addScaleAnimationToTokenButton()
    }

    @objc private func doThisWhenButtonIsTapped(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let text = appDelegate.token
        let textToShare = [text]
        let activityViewController = UIActivityViewController(activityItems: textToShare as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }

    private func constrainTokenButtonToWindow() {
        DispatchQueue.main.async {
            guard let keyWindow = UIApplication.shared.keyWindow,
                let tokenButton = self.tokenButton else { return }
            keyWindow.addSubview(tokenButton)
            keyWindow.trailingAnchor.constraint(equalTo: tokenButton.trailingAnchor,
                                                constant: 15).isActive = true
            keyWindow.bottomAnchor.constraint(equalTo: tokenButton.bottomAnchor,
                                              constant: 15).isActive = true
            tokenButton.widthAnchor.constraint(equalToConstant:
                PushTableViewController.buttonWidth).isActive = true
            tokenButton.heightAnchor.constraint(equalToConstant:
                PushTableViewController.buttonHeight).isActive = true
        }
    }

    private func addShadowToTokenButton() {
        tokenButton?.layer.shadowColor = UIColor.black.cgColor
        tokenButton?.layer.shadowOffset = CGSize(width: 0, height: 5)
        tokenButton?.layer.masksToBounds = false
        tokenButton?.layer.shadowRadius = 2
        tokenButton?.layer.shadowOpacity = 0.5
    }

    private func addScaleAnimationToTokenButton() {
        DispatchQueue.main.async {
            let scaleAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
            scaleAnimation.duration = 0.4
            scaleAnimation.repeatCount = .greatestFiniteMagnitude
            scaleAnimation.autoreverses = true
            scaleAnimation.fromValue = 1
            scaleAnimation.toValue = 1.3
            self.tokenButton?.layer.add(scaleAnimation, forKey: "scale")
        }
    }

}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension PushTableViewController {
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return pushStore.items.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PushItemCell",
                                                 for: indexPath)
        if let pushCell = cell as? PushItemCell {
            pushCell.updateWithPushItem(pushStore.items[indexPath.row])
        }
        return cell
    }
    
}
