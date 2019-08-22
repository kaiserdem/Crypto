//
//  BuyTradeVC.swift
//  Crypto
//
//  Created by Kaiserdem on 12.07.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

let keyHidenUiNotification = "KeyHidenUiNotification"
let keyShowUiNotification = "KeyShowUiNotification"

class BuyTradeVC: UIViewController, MTSlideToOpenDelegate, UITextFieldDelegate {
  
  @IBOutlet weak var backView: UIView!
  @IBOutlet weak var youPayCountLabel: UILabel!
  @IBOutlet weak var priceCountLabel: UILabel!
  @IBOutlet weak var maxButtonView: UIView!
  @IBOutlet weak var labelInTextFieldView: UILabel!
  @IBOutlet weak var amountTextField: UITextField!
  @IBOutlet weak var textFieldView: UIView!
  @IBOutlet weak var buySlideButton: MTSlideToOpenView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    amountTextField.delegate = self
    setSlideButtonSettings()
    
    textFieldView.layer.borderWidth = 1
    textFieldView.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
    textFieldView.layer.cornerRadius = 6
    
    maxButtonView.layer.borderWidth = 1
    maxButtonView.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
    maxButtonView.layer.cornerRadius = 6
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(doThisWhenNotify),
                                           name: NSNotification.Name(rawValue: keyHidenUiNotification),
                                           object: nil)
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(doThisWhenNotify),
                                           name: NSNotification.Name(rawValue: keyShowUiNotification),
                                           object: nil)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: keyHidenUiNotification), object: nil)
    
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: keyShowUiNotification), object: nil)
  }
  
  @objc func keyboardWillChange(notification: NSNotification) {
    
    NotificationCenter.default.post(name: Notification.Name(rawValue: keyHidenUiNotification), object: self)
    
    guard let keyboardRect = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
      return
    }
    if notification.name == UIResponder.keyboardWillShowNotification ||
      notification.name == UIResponder.keyboardWillChangeFrameNotification {
      view.frame.origin.y = -keyboardRect.height
    }else {
      NotificationCenter.default.post(name: Notification.Name(rawValue: keyShowUiNotification), object: self)
      view.frame.origin.y = 0
    }
  }
  @objc func doThisWhenNotify() {
  }
  
  @objc func setSlideButtonSettings() {
    buySlideButton.delegate = self
    buySlideButton.defaultSliderBackgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1) // вю которое на том что в сториб
    buySlideButton.sliderCornerRadious = 8
    buySlideButton.backgroundColor = .clear
    buySlideButton.thumnailImageView.backgroundColor = #colorLiteral(red: 0.4509803922, green: 0.6862745098, blue: 0.1490196078, alpha: 1)
    buySlideButton.textLabel.text = NSLocalizedString("→slide to buy", comment: "→slide to buy")
    buySlideButton.textLabel.font = UIFont(name:"Helvetica", size:12)
    let green = #colorLiteral(red: 0.4509803922, green: 0.6862745098, blue: 0.1490196078, alpha: 1)
    buySlideButton.draggedView.backgroundColor = green.withAlphaComponent(0.5)
  }
  
  func mtSlideToOpenDelegateDidFinish(_ sender: MTSlideToOpenView) {
    let alertController = UIAlertController(title: "", message: NSLocalizedString("Buy!", comment: "Buy"), preferredStyle: .alert)
    let doneAction = UIAlertAction(title: NSLocalizedString("Okay", comment: "Okay"), style: .default) { (action) in
      sender.resetStateWithAnimation(false)
    }
    alertController.addAction(doneAction)
    self.present(alertController, animated: true, completion: nil)
  }
  
  func hideKeyboard() {
    amountTextField.resignFirstResponder()
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    if amountTextField.text?.isEmpty == true {
      textFieldView.layer.borderColor = #colorLiteral(red: 0.9725490196, green: 0.5058823529, blue: 0.3960784314, alpha: 1)
    }
    
  }
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    youPayCountLabel.text = String(describing: textField.text! + " USD")
    return true
  }
  
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    textFieldView.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
    return true
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    hideKeyboard()
    return true
  }
}
