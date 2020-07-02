//
//  DateParser.swift
//  NotificationServiceExtension
//
//  Created by Anton Larchenko on 01.07.2020.
//  Copyright © 2020 Anton Larchenko. All rights reserved.
//

import UIKit

struct DateParser {
  static let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ru_RU")
    return formatter
  }()
  
  static func displayString(for date: Date) -> String {
    dateFormatter.dateFormat = "d MMMM yyyy, HH:mm"
    return dateFormatter.string(from: date)
  }
}
