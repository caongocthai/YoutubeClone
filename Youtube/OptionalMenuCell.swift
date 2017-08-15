//
//  OptionalMenuCell.swift
//  Youtube
//
//  Created by Harry Cao on 25/6/17.
//  Copyright © 2017 Apps Innovation. All rights reserved.
//

import UIKit

class OptionalMenuCell: BaseCollectionViewCell {
  
  var optionalMenu: OptionalMenu? {
    didSet {
      iconImageView.image = optionalMenu?.icon
      menuLabel.text = optionalMenu?.name.rawValue
    }
  }
  
  override var isHighlighted: Bool {
    didSet {
      self.backgroundColor = isHighlighted ? .lightGray : .white
      self.iconImageView.tintColor = isHighlighted ? .white : .gray
      self.menuLabel.textColor = isHighlighted ? .white : .gray
    }
  }
  
  let iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.tintColor = .gray
    return imageView
  }()
  
  let menuLabel: UILabel = {
    let label = UILabel()
    label.textColor = .gray
    label.font = UIFont.systemFont(ofSize: 14)
    return label
  }()
  
  override func setupCell() {
    self.addSubview(iconImageView)
    self.addSubview(menuLabel)
    
    _ = iconImageView.constraintCenterTo(centerX: nil, xConstant: nil, centerY: self.centerYAnchor, yConstant: 0)
    _ = iconImageView.constraintSizeToConstant(widthConstant: 28, heightConstant: 28)
    _ = iconImageView.constraintAnchorTo(top: nil, topConstant: nil, bottom: nil, bottomConstant: nil, left: self.leftAnchor, leftConstant: 16, right: nil, rightConstant: nil)
    
    _ = menuLabel.constraintAnchorTo(top: self.topAnchor, topConstant: 0, bottom: self.bottomAnchor, bottomConstant: 0, left: iconImageView.rightAnchor, leftConstant: 16, right: self.rightAnchor, rightConstant: 0)
  }
}
