//
//  SellTradeVC.swift
//  Crypto
//
//  Created by Kaiserdem on 12.07.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class SellTradeVC: UIViewController, MTSlideToOpenDelegate {
  
  @IBOutlet weak var youGetCountLabel: UILabel!
  @IBOutlet weak var priceCountLabel: UILabel!
  @IBOutlet weak var maxButtonView: UIView!
  @IBOutlet weak var labelInTextFieldView: UILabel!
  @IBOutlet weak var amountTextField: UITextField!
  @IBOutlet weak var textFieldView: UIView!
  @IBOutlet weak var buySlideButton: MTSlideToOpenView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setSlideButtonSettings()
    
    textFieldView.layer.borderWidth = 1
    textFieldView.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
    textFieldView.layer.cornerRadius = 6
    
    maxButtonView.layer.borderWidth = 1
    maxButtonView.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
    maxButtonView.layer.cornerRadius = 6
    
  }
  func setSlideButtonSettings() {
    buySlideButton.delegate = self
    buySlideButton.defaultSliderBackgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1) // вю которое на том что в сториб
    buySlideButton.sliderCornerRadious = 8
    buySlideButton.backgroundColor = .clear
    buySlideButton.thumnailImageView.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.5058823529, blue: 0.3960784314, alpha: 1)
    buySlideButton.textLabel.text = "→slide to sell"
    let green = #colorLiteral(red: 0.9725490196, green: 0.5058823529, blue: 0.3960784314, alpha: 1)
    buySlideButton.draggedView.backgroundColor = green.withAlphaComponent(0.5)
  }
  
  func mtSlideToOpenDelegateDidFinish(_ sender: MTSlideToOpenView) {
    let alertController = UIAlertController(title: "", message: "Sales!", preferredStyle: .alert)
    let doneAction = UIAlertAction(title: "Okay", style: .default) { (action) in
      sender.resetStateWithAnimation(false)
    }
    alertController.addAction(doneAction)
    self.present(alertController, animated: true, completion: nil)
    
  }
}
