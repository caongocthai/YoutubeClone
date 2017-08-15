//
//  Channel.swift
//  Youtube
//
//  Created by Harry Cao on 25/6/17.
//  Copyright © 2017 Apps Innovation. All rights reserved.
//

import Foundation

class Channel: NSObject {
  let name: String
  let profileImageUrl: String
  
  init(with dictionary: [String: AnyObject]) {
    self.name = dictionary["name"] as! String
    self.profileImageUrl = dictionary["profile_image_name"] as! String
  }
}
