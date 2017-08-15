//
//  ContentCollectionViewCell.swift
//  Youtube
//
//  Created by Harry Cao on 24/6/17.
//  Copyright © 2017 Apps Innovation. All rights reserved.
//

import UIKit

class ContentCollectionViewCell: BaseCollectionViewCell {
  let videoCellId = "videoCellId"
  
  var videos: [Video]?
  
  lazy var videoCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .white
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.showsVerticalScrollIndicator = false
    return collectionView
  }()
  
  override func setupCell() {
    videoCollectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: videoCellId)
    
    self.addSubview(videoCollectionView)
    _ = videoCollectionView.constraintAnchorTo(top: self.topAnchor, topConstant: 0, bottom: self.bottomAnchor, bottomConstant: 0, left: self.leftAnchor, leftConstant: 0, right: self.rightAnchor, rightConstant: 0)
    
    fetchVideos()
  }
  
  func fetchVideos() {
  }
}

extension ContentCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return videos?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = videoCollectionView.dequeueReusableCell(withReuseIdentifier: videoCellId, for: indexPath) as! VideoCollectionViewCell
    cell.video = videos![indexPath.item]
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let index = indexPath.item
    let thumbnailHeight: CGFloat = (self.frame.width - 32)*9/16
    
    var title = videos![index].title
    title = title.characters.count < 90 ? title : title.substring(to: title.index(title.startIndex, offsetBy: 90))
    let titleLabelTextAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)]
    let titleLabelheight = title.estimateFrameFor(size: CGSize(width: self.frame.width - 16 - 44 - 16 - 16, height: 10000), attributes: titleLabelTextAttributes).height
    
    var subLabel = videos![index].channel.name + " • " + String(describing: videos![index].numberOfViews) + " views"
    subLabel = subLabel.characters.count < 110 ? subLabel : subLabel.substring(to: subLabel.index(subLabel.startIndex, offsetBy: 110))
    let subLabelTextAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13)]
    let subLabelHeight = subLabel.estimateFrameFor(size: CGSize(width: self.frame.width - 16 - 44 - 16 - 16, height: 10000), attributes: subLabelTextAttributes).height
    
    let estimatedHeight = 16 + thumbnailHeight + 16 + titleLabelheight + subLabelHeight + 16
    
    return CGSize(width: self.frame.width, height: estimatedHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let videoContainerView = VideoContainerView()
    if let window = UIApplication.shared.keyWindow {
      videoContainerView.frame = CGRect(x: window.frame.width - 9, y: window.frame.height - 16, width: 9, height: 16)
      window.addSubview(videoContainerView)
      videoContainerView.showVideo()
      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
        videoContainerView.frame = window.frame
      }, completion: { (completed) in
        // may do smth
      })
    }
  }
}

