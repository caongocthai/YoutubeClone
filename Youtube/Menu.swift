//
//  Menu.swift
//  Youtube
//
//  Created by Harry Cao on 24/6/17.
//  Copyright © 2017 Apps Innovation. All rights reserved.
//

import UIKit

enum MenuName: String {
  case home = "Home"
  case trending = "Trending"
  case subscriptions = "Subscriptions"
  case account = "Account"
}

class Menu: NSObject {
  let name: MenuName
  let icon: UIImage
  
  init(name: MenuName, icon: UIImage) {
    self.name = name
    self.icon = icon
  }
}
