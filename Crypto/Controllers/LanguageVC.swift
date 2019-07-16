//
//  LanguageVC.swift
//  Crypto
//
//  Created by Kaiserdem on 16.07.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class LanguageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      view.backgroundColor = .white
      buttonEnglish()
      buttonRussian()
  }
  func buttonEnglish() {
    let button = UIButton(frame: CGRect(x: 20, y: 100, width: 100, height: 50))
    button.backgroundColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
    button.layer.cornerRadius = 6
    button.setTitle("English", for: .normal)
    button.addTarget(self, action: #selector(englishButtonAction), for: .touchUpInside)
    
    self.view.addSubview(button)
  }
  
  func buttonRussian() {
    let button = UIButton(frame: CGRect(x: 20, y: 200, width: 100, height: 50))
    button.backgroundColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
    button.layer.cornerRadius = 6
    button.setTitle("Russian", for: .normal)
    button.addTarget(self, action: #selector(russianButtonAction), for: .touchUpInside)
    
    self.view.addSubview(button)
  }
  @objc func englishButtonAction(sender: UIButton!) {
    print(" English Button tapped")
    self.changeToLanguage("en")

  }
  @objc func russianButtonAction(sender: UIButton!) {
    print(" Russian Button tapped")
    self.changeToLanguage("ru")

  }
  private func changeToLanguage(_ langCode: String) {
    if Bundle.main.preferredLocalizations.first != langCode {
      
      let confirmAlertCtrl = UIAlertController(title: NSLocalizedString("restartTitle", comment: ""), message: NSLocalizedString("restart", comment: ""), preferredStyle: .alert)
      
      let confirmAction = UIAlertAction(title: NSLocalizedString("close", comment: ""), style: .destructive) { _ in
        UserDefaults.standard.set([langCode], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        exit(EXIT_SUCCESS)
      }
      confirmAlertCtrl.addAction(confirmAction)
      
      let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: nil)
      confirmAlertCtrl.addAction(cancelAction)
      
      present(confirmAlertCtrl, animated: true, completion: nil)
    }
  }


  

}
