//
//  HomeViewController.swift
//  Youtube
//
//  Created by Harry Cao on 24/6/17.
//  Copyright © 2017 Apps Innovation. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  let homeCellId = "homeCellId"
  let trendingCellId = "trendingCellId"
  let subscriptionsCellId = "subscriptionsCellId"
  
  let menus: [Menu] = [
    Menu(name: .home, icon: #imageLiteral(resourceName: "home").withRenderingMode(.alwaysTemplate)),
    Menu(name: .trending, icon: #imageLiteral(resourceName: "trending").withRenderingMode(.alwaysTemplate)),
    Menu(name: .subscriptions, icon: #imageLiteral(resourceName: "subscriptions").withRenderingMode(.alwaysTemplate)),
    Menu(name: .account, icon: #imageLiteral(resourceName: "account").withRenderingMode(.alwaysTemplate))
  ]
  
  let defaultMenuIndex = 0
  
  lazy var menuTitleLabel: UILabel = {
    let label = UILabel()
    label.text = self.menus[self.defaultMenuIndex].name.rawValue
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 20)
    return label
  }()
  
  lazy var menuBar: MenuBar = {
    let menuBar = MenuBar()
    menuBar.menus = self.menus
    menuBar.defaultMenuIndex = self.defaultMenuIndex
    menuBar.setCurrentMenuDelegate = self
    return menuBar
  }()
  
  lazy var contentCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 0
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .white
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.isPagingEnabled = true
    return collectionView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .white
    setupNavigationBar()
    setupMenuBar()
    setupContentCollectionView()
  }
}

