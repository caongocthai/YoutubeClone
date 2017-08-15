//
//  SubscriptionsCell.swift
//  Youtube
//
//  Created by Harry Cao on 25/6/17.
//  Copyright © 2017 Apps Innovation. All rights reserved.
//

import UIKit

class SubscriptionsCell: ContentCollectionViewCell {
  override func fetchVideos() {
    APIService.sharedInstance.fetchSubscriptionsVideos { (videos) in
      self.videos = videos
      self.videoCollectionView.reloadData()
    }
  }
}
