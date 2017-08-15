//
//  MenuBar.swift
//  Youtube
//
//  Created by Harry Cao on 24/6/17.
//  Copyright © 2017 Apps Innovation. All rights reserved.
//

import UIKit

class MenuBar: UIView {
  let menuBarCellId = "menuBarCellId"
  
  var setCurrentMenuDelegate: SetCurrentMenuDelegate?
  
  lazy var menuCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 0
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .youtubeRed
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.showsHorizontalScrollIndicator = false
    return collectionView
  }()
  
  var indicatorBarConstraints = [NSLayoutConstraint]()
  let indicatorBar: UIView = {
    let indicatorBar = UIView()
    indicatorBar.backgroundColor = .white
    return indicatorBar
  }()
  
  var menus: [Menu]? {
    didSet {
      self.menuCollectionView.reloadData()
    }
  }
  
  var defaultMenuIndex: Int? {
    didSet {
      guard let defaultMenuIndex = defaultMenuIndex else { return }
      menuCollectionView.selectItem(at:  IndexPath(item: defaultMenuIndex, section: 0), animated: false, scrollPosition: UICollectionViewScrollPosition())
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.backgroundColor = .youtubeRed
    
    setupMenuCollectionView()
    setupIndicatorBar()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
