//
//  AuthVC.swift
//  Crypto
//
//  Created by Kaiserdem on 06.09.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {

  @IBOutlet weak var logInButtonOutlet: UIButton!
  @IBOutlet weak var singUpButtonOutlet: UIButton!
  @IBOutlet weak var scrollViewOutlet: UIScrollView!
  @IBOutlet weak var authButtonStackView: UIStackView!
  @IBOutlet weak var enterButtonOutler: UIButton!
  @IBOutlet weak var recommendedLblOutlet: UILabel!
  @IBOutlet weak var passwordTextFieldOutlet: UITextField!
  @IBOutlet weak var emailTextFieldOutlet: UITextField!
  @IBOutlet weak var googleBtnOutlet: UIButton!
  @IBOutlet weak var facebookBtnOutlet: UIButton!
  @IBOutlet weak var twitterBtnOutlet: UIButton!
  @IBOutlet weak var imageViewScreen: UIImageView!
  @IBOutlet weak var cancelBtnOutlet: UIButton!
  @IBOutlet weak var viewForAuthOutlet: UIView!
  
    override func viewDidLoad() {
        super.viewDidLoad()

      cancelBtnOutlet.tintColor = .white
      
      googleBtnOutlet.layer.borderWidth = 1
      googleBtnOutlet.layer.borderColor = UIColor.gray.cgColor
      googleBtnOutlet.layer.masksToBounds = true
      
      facebookBtnOutlet.layer.borderWidth = 1
      facebookBtnOutlet.layer.borderColor = UIColor.gray.cgColor
      facebookBtnOutlet.layer.masksToBounds = true
      
      twitterBtnOutlet.layer.borderWidth = 1
      twitterBtnOutlet.layer.borderColor = UIColor.gray.cgColor
      twitterBtnOutlet.layer.masksToBounds = true
      
      sellLogInBtn()
      
      self.hideKeyboardWhenTouchOutside()
      
      viewForAuthOutlet.dropShadowBottom()
      
    }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    animateViewMoving(up: true, moveValue: 100)
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    animateViewMoving(up: false, moveValue: 100)
  }
  func animateViewMoving (up:Bool, moveValue :CGFloat){
    let movementDuration:TimeInterval = 0.3
    let movement:CGFloat = ( up ? -moveValue : moveValue)
    UIView.beginAnimations( "animateView", context: nil)
    UIView.setAnimationBeginsFromCurrentState(true)
    UIView.setAnimationDuration(movementDuration )
    self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
    UIView.commitAnimations()
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    emailTextFieldOutlet.becomeFirstResponder()
    passwordTextFieldOutlet.resignFirstResponder()
    return true
  }
  
  func sellLogInBtn() {
    singUpButtonOutlet.alpha = 0.5
    singUpButtonOutlet.layer.shadowOpacity = 0.0
    
    logInButtonOutlet.alpha = 1
    logInButtonOutlet.layer.shadowOpacity = 0.1 // Тень всегда есть, но скрыта - показать тень
    logInButtonOutlet.layer.shadowOffset = CGSize(width: 0.0, height: -5.0) // направление тени
    logInButtonOutlet.layer.shadowRadius = 5.0  // насколько размыта тень
    
    self.passwordTextFieldOutlet.placeholder = "Enter your password"
    self.recommendedLblOutlet.text = "Forgot Password"
    self.enterButtonOutler.setTitle("Log In",for: .normal)
  }
  
  func sellSingInBtn() {
    
    logInButtonOutlet.alpha = 0.5
    logInButtonOutlet.layer.shadowOpacity = 0.0
    singUpButtonOutlet.alpha = 1
    singUpButtonOutlet.layer.shadowOpacity = 0.1
    singUpButtonOutlet.layer.shadowOffset = CGSize(width: 0.0, height: -5.0)
    singUpButtonOutlet.layer.shadowRadius = 5.0
    self.passwordTextFieldOutlet.placeholder = "Create new password"
    self.recommendedLblOutlet.text = "Recommended: min 8 characters, letters and numbers"
    self.enterButtonOutler.setTitle("Create Account",for: .normal)
  }
  
  @IBAction func cancelBtnAction(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func enterBtnAction(_ sender: UIButton) {
    
  }
  
  @IBAction func singUpButtonOutlet(_ sender: Any) {
    sellSingInBtn()
  }
  @IBAction func logInButtonAction(_ sender: Any) {
    sellLogInBtn()
  }
}

extension UIViewController {
  func hideKeyboardWhenTouchOutside() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(
      target: self,
      action: #selector(UIViewController.dismissKeyboard))
    
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}
