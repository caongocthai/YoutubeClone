//
//  HomeVC+setup.swift
//  Youtube
//
//  Created by Harry Cao on 24/6/17.
//  Copyright © 2017 Apps Innovation. All rights reserved.
//

import UIKit

extension HomeViewController: PresentOptionalMenuViewControllerDelegate {
  
  func setupNavigationBar() {
    guard let navigationController = self.navigationController else { return }
    
    navigationItem.titleView = menuTitleLabel
    menuTitleLabel.frame = CGRect(x: 0, y: 0, width: navigationController.navigationBar.frame.width - 36, height: navigationController.navigationBar.frame.height)
    
    navigationController.navigationBar.barTintColor = .youtubeRed
    navigationController.navigationBar.isTranslucent = false
    navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.white]
    
    navigationController.navigationBar.shadowImage = UIImage()
    navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController.navigationBar.tintColor = .white
    navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.white]
    
    let searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "search_icon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
    let optionalMenuButton = UIBarButtonItem(image: #imageLiteral(resourceName: "nav_more_icon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleOptionalMenuTap))
    navigationItem.rightBarButtonItems = [optionalMenuButton, searchButton]
  }
  
  @objc func handleSearch() {
    
  }
  
  @objc func handleOptionalMenuTap() {
    let optionalMenuView = OptionalMenuView(frame: (UIApplication.shared.keyWindow?.frame)!)
    optionalMenuView.presentOptionalMenuViewControllerDelegate = self
    if let window = UIApplication.shared.keyWindow {
      window.addSubview(optionalMenuView)
    }
    optionalMenuView.showOptionalMenu()
    
//    let oMV = OptionalMenuLauncher()
//    oMV.showOptionalMenu()
  }
  
  func presentOptionalMenuViewController(optionalMenu: OptionalMenu) {
    let optionalMenuViewController = UIViewController()
    optionalMenuViewController.view.backgroundColor = .white
    optionalMenuViewController.navigationItem.title = optionalMenu.name.rawValue
    optionalMenuViewController.navigationController?.navigationBar.tintColor = .white
    self.navigationController?.pushViewController(optionalMenuViewController, animated: true)
  }
  
  func setupMenuBar() {
    self.view.addSubview(menuBar)
    
    _ = menuBar.constraintAnchorTo(top: self.view.topAnchor, topConstant: 0, bottom: self.view.topAnchor, bottomConstant: 50, left: self.view.leftAnchor, leftConstant: 0, right: self.view.rightAnchor, rightConstant: 0)
  }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func setupContentCollectionView() {
    contentCollectionView.register(HomeCell.self, forCellWithReuseIdentifier: homeCellId)
    contentCollectionView.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
    contentCollectionView.register(SubscriptionsCell.self, forCellWithReuseIdentifier: subscriptionsCellId)
    
    self.view.addSubview(contentCollectionView)
    
    _ = contentCollectionView.constraintAnchorTo(top: self.view.topAnchor, topConstant: 50, bottom: self.view.bottomAnchor, bottomConstant: 0, left: self.view.leftAnchor, leftConstant: 0, right: self.view.rightAnchor, rightConstant: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return menus.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    var identifier = homeCellId
    
    if indexPath.item == 1 {
      identifier = trendingCellId
    } else if indexPath.item == 2 {
      identifier = subscriptionsCellId
    }
    
    let cell = contentCollectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.view.frame.width, height: self.view.frame.height - 50)
  }
}
