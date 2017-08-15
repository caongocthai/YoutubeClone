//
//  String+estimatedRect.swift
//  Youtube
//
//  Created by Harry Cao on 24/6/17.
//  Copyright © 2017 Apps Innovation. All rights reserved.
//

import UIKit

extension String {
  func estimateFrameFor(size: CGSize, attributes: [NSAttributedStringKey : Any]?) -> CGRect {
    let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
    return NSString(string: self).boundingRect(with: size, options: options, attributes: attributes, context: nil)
  }
}
