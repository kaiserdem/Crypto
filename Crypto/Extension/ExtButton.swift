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

extension UIButton {

  func setBackgroundColor(color: UIColor, forState: UIControl.State) {

    UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
    UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
    UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
    let colorImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    self.setBackgroundImage(colorImage, for: forState)
  }

}

extension UIButton {
  func roundedButton(setRoundingCorners:UIRectCorner){
    let maskPath1 = UIBezierPath(roundedRect: bounds,
                                 byRoundingCorners: [setRoundingCorners],
                                 cornerRadii: CGSize(width: 6, height: 6))
    let maskLayer1 = CAShapeLayer()
    maskLayer1.frame = bounds
    maskLayer1.path = maskPath1.cgPath
    layer.mask = maskLayer1
  }
}

extension UIButton{
  enum ImageTitleRelativeLocation {
    case imageUpTitleDown
    case imageDownTitleUp
    case imageLeftTitleRight
    case imageRightTitleLeft
  }
  func centerContentRelativeLocation(_ relativeLocation:
    ImageTitleRelativeLocation,
                                     spacing: CGFloat = 0) {
    assert(contentVerticalAlignment == .center,
           "only works with contentVerticalAlignment = .center !!!")

    guard (title(for: .normal) != nil) || (attributedTitle(for: .normal) != nil) else {
      assert(false, "TITLE IS NIL! SET TITTLE FIRST!")
      return
    }

    guard let imageSize = self.currentImage?.size else {
      assert(false, "IMGAGE IS NIL! SET IMAGE FIRST!!!")
      return
    }
    guard let titleSize = titleLabel?
      .systemLayoutSizeFitting(UIView.layoutFittingCompressedSize) else {
        assert(false, "TITLELABEL IS NIL!")
        return
    }

    let horizontalResistent: CGFloat
    // extend contenArea in case of title is shrink
    if frame.width < titleSize.width + imageSize.width {
      horizontalResistent = titleSize.width + imageSize.width - frame.width
      print("horizontalResistent", horizontalResistent)
    } else {
      horizontalResistent = 0
    }

    var adjustImageEdgeInsets: UIEdgeInsets = .zero
    var adjustTitleEdgeInsets: UIEdgeInsets = .zero
    var adjustContentEdgeInsets: UIEdgeInsets = .zero

    let verticalImageAbsOffset = abs((titleSize.height + spacing) / 2)
    let verticalTitleAbsOffset = abs((imageSize.height + spacing) / 2)

    switch relativeLocation {
    case .imageUpTitleDown:

      adjustImageEdgeInsets.top = -verticalImageAbsOffset
      adjustImageEdgeInsets.bottom = verticalImageAbsOffset
      adjustImageEdgeInsets.left = titleSize.width / 2 + horizontalResistent / 2
      adjustImageEdgeInsets.right = -titleSize.width / 2 - horizontalResistent / 2

      adjustTitleEdgeInsets.top = verticalTitleAbsOffset
      adjustTitleEdgeInsets.bottom = -verticalTitleAbsOffset
      adjustTitleEdgeInsets.left = -imageSize.width / 2 + horizontalResistent / 2
      adjustTitleEdgeInsets.right = imageSize.width / 2 - horizontalResistent / 2

      adjustContentEdgeInsets.top = spacing
      adjustContentEdgeInsets.bottom = spacing
      adjustContentEdgeInsets.left = -horizontalResistent
      adjustContentEdgeInsets.right = -horizontalResistent
    case .imageDownTitleUp:
      adjustImageEdgeInsets.top = verticalImageAbsOffset
      adjustImageEdgeInsets.bottom = -verticalImageAbsOffset
      adjustImageEdgeInsets.left = titleSize.width / 2 + horizontalResistent / 2
      adjustImageEdgeInsets.right = -titleSize.width / 2 - horizontalResistent / 2

      adjustTitleEdgeInsets.top = -verticalTitleAbsOffset
      adjustTitleEdgeInsets.bottom = verticalTitleAbsOffset
      adjustTitleEdgeInsets.left = -imageSize.width / 2 + horizontalResistent / 2
      adjustTitleEdgeInsets.right = imageSize.width / 2 - horizontalResistent / 2

      adjustContentEdgeInsets.top = spacing
      adjustContentEdgeInsets.bottom = spacing
      adjustContentEdgeInsets.left = -horizontalResistent
      adjustContentEdgeInsets.right = -horizontalResistent
    case .imageLeftTitleRight:
      adjustImageEdgeInsets.left = -spacing / 2
      adjustImageEdgeInsets.right = spacing / 2

      adjustTitleEdgeInsets.left = spacing / 2
      adjustTitleEdgeInsets.right = -spacing / 2

      adjustContentEdgeInsets.left = spacing
      adjustContentEdgeInsets.right = spacing
    case .imageRightTitleLeft:
      adjustImageEdgeInsets.left = titleSize.width + spacing / 2
      adjustImageEdgeInsets.right = -titleSize.width - spacing / 2

      adjustTitleEdgeInsets.left = -imageSize.width - spacing / 2
      adjustTitleEdgeInsets.right = imageSize.width + spacing / 2

      adjustContentEdgeInsets.left = spacing
      adjustContentEdgeInsets.right = spacing
    }

    imageEdgeInsets = adjustImageEdgeInsets
    titleEdgeInsets = adjustTitleEdgeInsets
    contentEdgeInsets = adjustContentEdgeInsets

    setNeedsLayout()
  }

}
