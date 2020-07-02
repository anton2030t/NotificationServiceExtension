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
