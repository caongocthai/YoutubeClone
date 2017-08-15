//
//  MenuBar+setup.swift
//  Youtube
//
//  Created by Harry Cao on 24/6/17.
//  Copyright © 2017 Apps Innovation. All rights reserved.
//

import UIKit

extension MenuBar {
  func setupIndicatorBar() {
    self.addSubview(indicatorBar)
    _ = indicatorBar.constraintSizeToMultipler(widthAnchor: self.widthAnchor, widthMultiplier: 1/4, heightAnchor: nil, heightMultiplier: nil)
    _ = indicatorBar.constraintSizeToConstant(widthConstant: nil, heightConstant: 4)
    indicatorBarConstraints = indicatorBar.constraintAnchorTo(top: nil, topConstant: nil, bottom: self.bottomAnchor, bottomConstant: 0, left: self.leftAnchor, leftConstant: 0, right: nil, rightConstant: nil)
  }
}

extension MenuBar: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func setupMenuCollectionView() {
    menuCollectionView.register(MenuBarCell.self, forCellWithReuseIdentifier: menuBarCellId)
    self.addSubview(menuCollectionView)
    
    _ = menuCollectionView.constraintAnchorTo(top: self.topAnchor, topConstant: 0, bottom: self.bottomAnchor, bottomConstant: 0, left: self.leftAnchor, leftConstant: 0, right: self.rightAnchor, rightConstant: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return menus?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: menuBarCellId, for: indexPath) as! MenuBarCell
    
    cell.iconImageView.image = menus?[indexPath.item].icon
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.frame.width/4, height: self.frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    setCurrentMenuDelegate?.setCurrentMenu(with: indexPath.item)
  }
}
