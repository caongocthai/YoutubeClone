//
//  HomeCell.swift
//  Youtube
//
//  Created by Harry Cao on 25/6/17.
//  Copyright © 2017 Apps Innovation. All rights reserved.
//

import UIKit

class HomeCell: ContentCollectionViewCell {
  override func fetchVideos() {
    APIService.sharedInstance.fetchHomeVideos { (videos) in
      self.videos = videos
      self.videoCollectionView.reloadData()
    }
  }
}
