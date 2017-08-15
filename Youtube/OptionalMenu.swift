//
//  OptionalMenu.swift
//  Youtube
//
//  Created by Harry Cao on 25/6/17.
//  Copyright © 2017 Apps Innovation. All rights reserved.
//

import UIKit

enum OptionalMenuName: String {
  case settings = "Settings"
  case termsAndPrivacyPolicy = "Terms & privacy policy"
  case sendFeedback = "Send Feedback"
  case help = "Help"
  case switchAccount = "Switch Account"
  case cancel = "Cancel"
}

class OptionalMenu: NSObject {
  let name: OptionalMenuName
  let icon: UIImage
  
  init(name: OptionalMenuName, icon: UIImage) {
    self.name = name
    self.icon = icon
  }
}
