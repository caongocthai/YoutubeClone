//
//  CachedImageView.swift
//  Youtube
//
//  Created by Harry Cao on 25/6/17.
//  Copyright © 2017 Apps Innovation. All rights reserved.
//

import UIKit

class CachedImageView: UIImageView {
  static let imageCache = NSCache<NSString, UIImage>()
  
  private var urlStringForChecking: String?
  
  var shouldUseEmptyImage = true
  private var emptyImage: UIImage?
  
  
  func loadImageUsingCache(with urlString: String, completion: (() -> ())? = nil) {
    // Prevent deque cell reuse the image of another cell
    self.image = nil
    
    // set url for checking
    self.urlStringForChecking = urlString
    
    // check cache
    let urlKey = urlString as NSString
    if let cachedImage = CachedImageView.imageCache.object(forKey: urlKey) {
      self.image = cachedImage
      completion?()
      return
    }
    
    // Validate url
    guard let url = URL(string: urlString) else {
      if shouldUseEmptyImage {
        image = emptyImage
      }
      return
    }
    
    // If no cachedImage, fire a new download
    URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
      if error != nil {
        return
      }
      
      DispatchQueue.main.async {
        if let image = UIImage(data: data!) {
          CachedImageView.imageCache.setObject(image, forKey: urlKey)
          if urlString == self?.urlStringForChecking {
            self?.image = image
            completion?()
          }
        }
      }
      
    }).resume()
  }
}
