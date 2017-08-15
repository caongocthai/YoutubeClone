//
//  HomeVC+ChangeMenu.swift
//  Youtube
//
//  Created by Harry Cao on 24/6/17.
//  Copyright © 2017 Apps Innovation. All rights reserved.
//

import UIKit

extension HomeViewController: SetCurrentMenuDelegate {
  func setCurrentMenu(with index: Int) {
    menuTitleLabel.text = menus[Int(index)].name.rawValue
    contentCollectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: UICollectionViewScrollPosition(), animated: true)
  }
}

extension HomeViewController {
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let index = targetContentOffset.pointee.x/self.view.frame.width
    
    menuTitleLabel.text = menus[Int(index)].name.rawValue
    menuBar.menuCollectionView.selectItem(at: IndexPath(item: Int(index), section: 0), animated: true, scrollPosition: UICollectionViewScrollPosition())
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    menuBar.indicatorBarConstraints[1].constant = scrollView.contentOffset.x / 4
  }
}
