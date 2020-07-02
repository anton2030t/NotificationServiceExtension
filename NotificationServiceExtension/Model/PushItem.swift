//
//  PushItem.swift
//  NotificationServiceExtension
//
//  Created by Anton Larchenko on 01.07.2020.
//  Copyright © 2020 Anton Larchenko. All rights reserved.
//

import Foundation

struct PushItem: Codable {
  let title: String
  let date: Date
  
  @discardableResult
  static func makePushItem(_ notification: [String: AnyObject]) -> PushItem? {

    var push: String
    
    guard let silent = notification["content-available"] as? Int else { return nil }
    
    if silent == 1 {
        guard let numberInt = notification["number"] as? String else { return nil }
        push = String(Int(numberInt)! * 2)
    } else {
        guard let pushText = notification["message"] as? String else { return nil }
        push = pushText
    }
    
    let pushItem = PushItem(title: push, date: Date())
    let pushStore = PushStore.shared
    pushStore.add(item: pushItem)
    
    NotificationCenter.default.post(name: PushTableViewController.refreshPushNotification, object: self)
    
    return pushItem
  }
}
