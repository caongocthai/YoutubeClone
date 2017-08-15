//
//  VideoContainerView.swift
//  Youtube
//
//  Created by Harry Cao on 26/6/17.
//  Copyright © 2017 Apps Innovation. All rights reserved.
//

import UIKit

class VideoContainerView: UIView {
  let miniWidth: CGFloat = 192
  let miniHeight: CGFloat = 108
  
  var isExpandingOrShrinking = false
  var isMini = false
  
  var isDimishing = false
  
  lazy var secondaryContainerView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    return view
  }()
  lazy var videoPlayerView: VideoPlayerView = {
    let videoPlayerHeight = self.frame.width * 9 / 16
    let videoPlayerFrame = CGRect(x: 0, y: 0, width: self.frame.width, height: videoPlayerHeight)
    let view = VideoPlayerView(frame: videoPlayerFrame)
    view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanVideoPlayer)))
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.backgroundColor = .clear
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func showVideo() {
    self.addSubview(secondaryContainerView)
    self.addSubview(videoPlayerView)
    
    _ = videoPlayerView.constraintAnchorTo(top: self.topAnchor, topConstant: 0, bottom: nil, bottomConstant: nil, left: self.leftAnchor, leftConstant: 0, right: self.rightAnchor, rightConstant: 0)
    _ = videoPlayerView.constraintSizeToMultipler(widthAnchor: nil, widthMultiplier: nil, heightAnchor: videoPlayerView.widthAnchor, heightMultiplier: 9/16)
    
    _ = secondaryContainerView.constraintAnchorTo(top: videoPlayerView.bottomAnchor, topConstant: 0, bottom: self.bottomAnchor, bottomConstant: 0, left: self.leftAnchor, leftConstant: 0, right: self.rightAnchor, rightConstant: 0)
  }
  
  @objc func handlePanVideoPlayer(_ gesture: UIPanGestureRecognizer) {
    if let window = UIApplication.shared.keyWindow {
      let shiftX = gesture.translation(in: window).x
      let shiftY = gesture.translation(in: window).y
      let velocityX = gesture.velocity(in: window).x
      let velocityY = gesture.velocity(in: window).y
      
      if isMini && !isExpandingOrShrinking && (isDimishing || velocityY > -50) && shiftX < 0 {
        isDimishing = true
        
        self.frame.origin.x = window.frame.width - miniWidth + shiftX
        videoPlayerView.alpha = pow(1 - abs(shiftX)/window.frame.width, 1/3)
        
        if gesture.state == .ended {
          let isMovingLeft = velocityX < 50
          UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.frame.origin.x = isMovingLeft ? -self.miniWidth : window.frame.width - self.miniWidth
            self.videoPlayerView.alpha = isMovingLeft ? 0 : 1
          }, completion: { (completed) in
            self.isDimishing = false
            if isMovingLeft {
              self.removeFromSuperview()
            }
          })
        }
      }
      
      if isDimishing {
        if shiftX > 0 {
          self.frame = CGRect(x: window.frame.width - self.miniWidth, y: window.frame.height - self.miniHeight, width: self.miniWidth, height: self.miniHeight)
          isDimishing = false
        }
        return
      }
      
      isExpandingOrShrinking = true
      
      if shiftY < 0 && !isMini {
        self.frame = window.frame
        secondaryContainerView.alpha = 1
        isExpandingOrShrinking = false
        return
      } else if shiftY > 0 && isMini {
        self.frame = CGRect(x: window.frame.width - self.miniWidth, y: window.frame.height - self.miniHeight, width: self.miniWidth, height: self.miniHeight)
        secondaryContainerView.alpha = 0
        isExpandingOrShrinking = false
        return
      }
      
      let scale = isMini ? 2 - (window.frame.height - shiftY)/window.frame.height : shiftY/window.frame.height
      let newOriginX = scale*(window.frame.width - miniWidth)
      let newOriginY = scale*(window.frame.height - miniHeight)
      let newWidth = window.frame.width - newOriginX
      let newHeight = window.frame.height - newOriginY
      self.frame = CGRect(x: newOriginX, y: newOriginY, width: newWidth, height: newHeight)
      secondaryContainerView.alpha = 1 - scale
      
      if gesture.state == .ended {
        let isMovingDown = velocityY > 50
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
          self.frame = isMovingDown ? CGRect(x: window.frame.width - self.miniWidth, y: window.frame.height - self.miniHeight, width: self.miniWidth, height: self.miniHeight) : window.frame
          self.secondaryContainerView.alpha = isMovingDown ? 0 : 1
        }, completion: { (completed) in
          self.isMini = isMovingDown
          self.isExpandingOrShrinking = false
        })
      }
    }
  }
}
