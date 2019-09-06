//
//  ExtUIViewShadow.swift
//  Crypto
//
//  Created by Kaiserdem on 05.09.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

extension UIView {
  
  func dropShadowBottom() {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.gray.cgColor
    layer.shadowOpacity = 0.3
    layer.shadowOffset = CGSize(width: 0, height: 3)
    layer.shadowRadius = 2
  }
  func dropShadowTop() {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.gray.cgColor
    layer.shadowOpacity = 0.5
    layer.shadowOffset = CGSize(width: 0, height: -3)
    layer.shadowRadius = 2
  }
  func dropShadowTopEnable() {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.gray.cgColor
    layer.shadowOpacity = 0.0
    layer.shadowOffset = CGSize(width: 0, height: 0)
    layer.shadowRadius = 0
  }
}
