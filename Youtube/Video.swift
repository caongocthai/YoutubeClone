//
//  Video.swift
//  Youtube
//
//  Created by Harry Cao on 24/6/17.
//  Copyright © 2017 Apps Innovation. All rights reserved.
//

import UIKit

class Video: NSObject {
  let title: String
  let thumbnailImageUrl: String
  let duration: NSNumber
  let numberOfViews: NSNumber
  let channel: Channel
  
  init(with dictionary: [String: AnyObject]) {
    self.title = dictionary["title"] as! String
    self.thumbnailImageUrl = dictionary["thumbnail_image_name"] as! String
    self.duration = dictionary["duration"] as! NSNumber
    self.numberOfViews = dictionary["number_of_views"] as! NSNumber
    self.channel = Channel(with: dictionary["channel"] as! [String: AnyObject])
  }
}
