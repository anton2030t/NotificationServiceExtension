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
    
    let tokenEntry: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 15)
        view.backgroundColor = .clear
        view.isEditable = false
        return view
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(PushTableViewController.getToken(notification:)), name: Notification.Name("getToken"), object: nil)

        tokenEntry.isScrollEnabled = false
                
        view.addSubview(tokenEntry)
        setupTokenEntry()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(PushTableViewController.receivedRefreshPushNotification(_:)),
            name: PushTableViewController.refreshPushNotification,
            object: nil)
    }
    
    @objc func getToken(notification: Notification) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        tokenEntry.text = appDelegate.token
    }
    
    func setupTokenEntry() {
        tokenEntry.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tokenEntry.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tokenEntry.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tokenEntry.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func receivedRefreshPushNotification(_ notification: Notification) {
        DispatchQueue.main.async {
            self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
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
