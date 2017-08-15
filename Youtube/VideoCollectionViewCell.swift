//
//  VideoCollectionViewCell.swift
//  Youtube
//
//  Created by Harry Cao on 24/6/17.
//  Copyright © 2017 Apps Innovation. All rights reserved.
//

import UIKit

class VideoCollectionViewCell: BaseCollectionViewCell {
  var video: Video? {
    didSet {
      guard let video = video else { return }
      self.videoTitleLabel.text = video.title
      self.videoSubLabel.text = video.channel.name + " • " + String(describing: video.numberOfViews) + " views"
      self.thumbnailImageView.loadImageUsingCache(with: video.thumbnailImageUrl)
      self.profilePictureImageView.loadImageUsingCache(with: video.channel.profileImageUrl)
    }
  }
  
  let thumbnailImageView: CachedImageView = {
    let imageView = CachedImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  
  lazy var profilePictureImageView: CachedImageView = {
    let imageView = CachedImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 22
    imageView.layer.masksToBounds = true
    imageView.isUserInteractionEnabled = true
    imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapProfilePicture)))
    return imageView
  }()
  
  let videoTitleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 15)
    label.numberOfLines = 2
    label.sizeToFit()
    return label
  }()
  
  let videoSubLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 13)
    label.textColor = .lightGray
    label.numberOfLines = 2
    label.sizeToFit()
    return label
  }()
  
  lazy var labelsStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fillProportionally
    stackView.addArrangedSubview(self.videoTitleLabel)
    stackView.addArrangedSubview(self.videoSubLabel)
    return stackView
  }()
  
  let separatorLine: UIView = {
    let line = UIView()
    line.backgroundColor = UIColor(r: 230, g: 230, b: 230)
    return line
  }()
  
  override func setupCell() {
    super.setupCell()
    
    self.addSubview(thumbnailImageView)
    self.addSubview(profilePictureImageView)
    self.addSubview(labelsStackView)
    self.addSubview(separatorLine)
    
    _ = thumbnailImageView.constraintAnchorTo(top: self.topAnchor, topConstant: 16, bottom: nil, bottomConstant: nil, left: self.leftAnchor, leftConstant: 16, right: self.rightAnchor, rightConstant: -16)
    _ = thumbnailImageView.constraintSizeToMultipler(widthAnchor: nil, widthMultiplier: nil, heightAnchor: thumbnailImageView.widthAnchor, heightMultiplier: 9/16)
    
    _ = profilePictureImageView.constraintAnchorTo(top: thumbnailImageView.bottomAnchor, topConstant: 8, bottom: nil, bottomConstant: nil, left: thumbnailImageView.leftAnchor, leftConstant: 0, right: nil, rightConstant: nil)
    _ = profilePictureImageView.constraintSizeToConstant(widthConstant: 44, heightConstant: 44)
    
    _ = labelsStackView.constraintAnchorTo(top: profilePictureImageView.topAnchor, topConstant: 0, bottom: self.bottomAnchor, bottomConstant: -16, left: profilePictureImageView.rightAnchor, leftConstant: 16, right: thumbnailImageView.rightAnchor, rightConstant: -16)
    
    _ = separatorLine.constraintAnchorTo(top: self.bottomAnchor, topConstant: -1, bottom: self.bottomAnchor, bottomConstant: 0, left: self.leftAnchor, leftConstant: 0, right: self.rightAnchor, rightConstant: 0)
  }
  
  @objc func handleTapProfilePicture() {
    print("tap profile pic")
  }
}
