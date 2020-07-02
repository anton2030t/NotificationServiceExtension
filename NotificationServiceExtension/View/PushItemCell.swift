//
//  PushItemCell.swift
//  NotificationServiceExtension
//
//  Created by Anton Larchenko on 01.07.2020.
//  Copyright © 2020 Anton Larchenko. All rights reserved.
//

import UIKit

class PushItemCell: UITableViewCell {
  func updateWithPushItem(_ item: PushItem) {
    textLabel?.text = item.title
    detailTextLabel?.text = DateParser.displayString(for: item.date)
  }
}
