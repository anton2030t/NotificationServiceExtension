//
//  PushStore.swift
//  NotificationServiceExtension
//
//  Created by Anton Larchenko on 01.07.2020.
//  Copyright © 2020 Anton Larchenko. All rights reserved.
//

import UIKit

class PushStore {
  static let shared = PushStore()
  
  var items: [PushItem] = []
  
  init() {
    loadItemsFromCache()
  }
  
  func add(item: PushItem) {
    items.insert(item, at: 0)
    saveItemsToCache()
  }
}


// MARK: Persistance
extension PushStore {
  func saveItemsToCache() {
    do {
      let data = try JSONEncoder().encode(items)
      try data.write(to: itemsCache)
    } catch {
      print("Error saving push items: \(error)")
    }
  }
  
  func loadItemsFromCache() {
    do {
      guard FileManager.default.fileExists(atPath: itemsCache.path) else {
        print("No push file exists yet.")
        return
      }
      let data = try Data(contentsOf: itemsCache)
      items = try JSONDecoder().decode([PushItem].self, from: data)
    } catch {
      print("Error loading push items: \(error)")
    }
  }
  
  var itemsCache: URL {
    let documentsURL = FileManager.default.urls(for: .documentDirectory,
                                                in: .userDomainMask)[0]
    return documentsURL.appendingPathComponent("push.dat")
  }
}
