//
//  BaseCollectionViewCell.swift
//  Youtube
//
//  Created by Harry Cao on 24/6/17.
//  Copyright © 2017 Apps Innovation. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupCell()
  }
  
  func setupCell() { }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
