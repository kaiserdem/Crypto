//
//  ExtensionButton.swift
//  Crypto
//
//  Created by Kaiserdem on 28.06.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

extension UIButton {

  func flash() { // мигание

    let flash = CABasicAnimation(keyPath: "opacity")
    flash.duration = 0.5
    flash.fromValue = 1
    flash.toValue = 0.1
    flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    flash.autoreverses = true
    flash.repeatCount = 5
    
    DispatchQueue.main.async { [weak self] in
      
      self?.layer.add(flash, forKey: "opacity")
    }
  }
}
