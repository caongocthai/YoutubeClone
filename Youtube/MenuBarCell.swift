//
//  MenuBarCell.swift
//  Youtube
//
//  Created by Harry Cao on 24/6/17.
//  Copyright © 2017 Apps Innovation. All rights reserved.
//

import UIKit

class MenuBarCell: BaseCollectionViewCell {
  let iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.tintColor = .inactiveMenu
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  override var isHighlighted: Bool {
    didSet {
      self.iconImageView.tintColor = isHighlighted ? .white : .inactiveMenu
    }
  }
  
  override var isSelected: Bool {
    didSet {
      self.iconImageView.tintColor = isSelected ? .white : .inactiveMenu
    }
  }
  
  override func setupCell() {
    super.setupCell()
    
    self.addSubview(iconImageView)
    _ = iconImageView.constraintSizeToConstant(widthConstant: 28, heightConstant: 28)
    _ = iconImageView.constraintCenterTo(centerX: self.centerXAnchor, xConstant: 0, centerY: self.centerYAnchor, yConstant: 0)
  }
}
