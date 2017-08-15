//
//  OptionalMenuView.swift
//  Youtube
//
//  Created by Harry Cao on 25/6/17.
//  Copyright © 2017 Apps Innovation. All rights reserved.
//

import UIKit

class OptionalMenuView: UIView {
  let optionMenuCellId = "optionMenuCellId"
  
  lazy var backgroundView: UIView = {
    let view = UIView(frame: self.frame)
    view.backgroundColor = UIColor(white: 0, alpha: 0.7)
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapBackground)))
    view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanBackground)))
    return view
  }()
  
  let optionalMenus = [
    OptionalMenu(name: .settings, icon: #imageLiteral(resourceName: "settings").withRenderingMode(.alwaysTemplate)),
    OptionalMenu(name: .termsAndPrivacyPolicy, icon: #imageLiteral(resourceName: "privacy").withRenderingMode(.alwaysTemplate)),
    OptionalMenu(name: .sendFeedback, icon: #imageLiteral(resourceName: "feedback").withRenderingMode(.alwaysTemplate)),
    OptionalMenu(name: .help, icon: #imageLiteral(resourceName: "help").withRenderingMode(.alwaysTemplate)),
    OptionalMenu(name: .switchAccount, icon: #imageLiteral(resourceName: "switch_account").withRenderingMode(.alwaysTemplate)),
    OptionalMenu(name: .cancel, icon: #imageLiteral(resourceName: "cancel").withRenderingMode(.alwaysTemplate))
  ]
  
  let cellHeight: CGFloat = 50
  var menuCollectionViewHeight: CGFloat!
  
  var menuCollectionViewContraints = [NSLayoutConstraint]()
  lazy var menuCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = .white
    collectionView.isScrollEnabled = false
    return collectionView
  }()
  
  var presentOptionalMenuViewControllerDelegate: PresentOptionalMenuViewControllerDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    menuCollectionViewHeight = CGFloat(optionalMenus.count)*cellHeight
    
    menuCollectionView.register(OptionalMenuCell.self, forCellWithReuseIdentifier: optionMenuCellId)
  }
  
  func showOptionalMenu() {
    self.addSubview(backgroundView)
    self.addSubview(menuCollectionView)
    
    menuCollectionView.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: self.frame.height)
    
    backgroundView.alpha = 0
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
      self.backgroundView.alpha = 1
      self.menuCollectionView.frame.origin.y = self.frame.height - self.menuCollectionViewHeight
    }) { (completed) in
      // do smth
    }
  }
  
  @objc func handlePanBackground(_ gesture: UIPanGestureRecognizer) {
    let translation = gesture.translation(in: self)
    backgroundView.alpha = pow(1 - translation.y/self.frame.height, 2)
    menuCollectionView.frame.origin.y = self.frame.height - menuCollectionViewHeight + translation.y
    
    if gesture.state == .ended {
      let velocity = gesture.velocity(in: self)
      if velocity.y > 50 {
        dismiss()
      } else {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
          self.menuCollectionView.frame.origin.y = self.frame.height - self.menuCollectionViewHeight
          self.backgroundView.alpha = 1
        }, completion: nil)
      }
    }
    
    
  }
  
  @objc func handleTapBackground() {
    dismiss()
  }
  
  func dismiss(optionalMenu: OptionalMenu? = nil) {
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
      self.backgroundView.alpha = 0
      self.menuCollectionView.frame.origin.y = self.frame.height
    }) { (completed) in
      self.backgroundView.removeFromSuperview()
      self.menuCollectionView.removeFromSuperview()
      self.removeFromSuperview()
      if let optionalMenu = optionalMenu,let delegate = self.presentOptionalMenuViewControllerDelegate {
        delegate.presentOptionalMenuViewController(optionalMenu: optionalMenu)
      }
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension OptionalMenuView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return optionalMenus.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: optionMenuCellId, for: indexPath) as! OptionalMenuCell
    cell.optionalMenu = optionalMenus[indexPath.item]
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: menuCollectionView.frame.width, height: cellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedOptionalMenu = optionalMenus[indexPath.item]
    dismiss(optionalMenu: selectedOptionalMenu.name == .cancel ? nil : selectedOptionalMenu)
  }
}
