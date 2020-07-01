//
//  ViewController.swift
//  NotificationServiceExtension
//
//  Created by Anton Larchenko on 30.06.2020.
//  Copyright © 2020 Anton Larchenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let pushs = [PushModel]()
    
    @IBOutlet weak var pushTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pushTableView.register(UINib(nibName: PushCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: PushCell.identifier)
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pushs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PushCell.identifier) as! PushCell
        return cell
    }
    
    
}
