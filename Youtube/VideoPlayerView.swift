//
//  VideoPlayerView.swift
//  Youtube
//
//  Created by Harry Cao on 26/6/17.
//  Copyright © 2017 Apps Innovation. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
  
  var player = AVPlayer()
  var playerLayer = AVPlayerLayer()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .black
    let urlString = "https://firebasestorage.googleapis.com/v0/b/theflashmessager.appspot.com/o/message_videos%2F3C238DCC-41BB-4FCF-88C5-74DB38004161.mov?alt=media&token=bd7f5999-b42b-4a36-a45e-92f8a21efb4e"
//    let urlString = "https://firebasestorage.googleapis.com/v0/b/theflashmessager.appspot.com/o/message_videos%2FADCF2F07-DDD0-44AD-89F0-4A6DD30CB3AC.mov?alt=media&token=3dccb08a-1c3d-41f7-ba3f-9427195a21fc"
    if let url = URL(string: urlString) {
      player = AVPlayer(url: url)
      
      playerLayer = AVPlayerLayer(player: player)
      self.layer.addSublayer(playerLayer)
      playerLayer.frame = self.frame
      
      player.play()
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    playerLayer.frame = self.frame
  }
}

