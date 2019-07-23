//
//  SettingVC.swift
//  Crypto
//
//  Created by Kaiserdem on 20.06.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {

 
  @IBOutlet weak var selectLanguage: UILabel!
  @IBOutlet weak var currentLanguage: UILabel!
  @IBOutlet weak var languageLabel: UILabel!
  @IBOutlet weak var languageButtonView: UIView!
  @IBOutlet weak var alertsButtonView: UIView!
  @IBOutlet weak var exchangesButtonView: UIView!
  @IBOutlet weak var generalButtonView: UIView!
  @IBOutlet weak var rightColorView: UIView!
  @IBOutlet weak var firstBackView: UIView!
  @IBOutlet weak var backCornerView: UIView!
  
  @IBOutlet weak var grayViewHeaderAppSettings: UIView!
  override func viewDidLoad() {
        super.viewDidLoad()

    setupNavBarSettings()
    setupSettingsBarGestures()
    setupLanguageGestured()
    openGeneralButton()
    backCornerView.layer.cornerRadius = 8
    firstBackView.sendSubviewToBack(rightColorView)
    
    generalButtonView.layer.cornerRadius = 6
    exchangesButtonView.layer.cornerRadius = 6
    alertsButtonView.layer.cornerRadius = 6
    
    grayViewHeaderAppSettings.layer.borderWidth = 1
    grayViewHeaderAppSettings.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)
    
    if selectLanguage.text == "Seleccione el idioma" {
      currentLanguage.text = "Español"
    } else if selectLanguage.text == "Выбрать язык" {
      currentLanguage.text = "Русский"
    }
    
  }
    
  private func setupNavBarSettings() {
    let colors: [UIColor] = [#colorLiteral(red: 0, green: 0.7960784314, blue: 0.7921568627, alpha: 1), #colorLiteral(red: 0.4509803922, green: 0.6862745098, blue: 0.1490196078, alpha: 1)]
    let titleLabel = UILabel(frame: CGRect(x: view.center.x, y: view.center.y, width: 0, height:0))
    titleLabel.text = NSLocalizedString("Setting", comment: "Setting")
    titleLabel.textColor = UIColor.white
    titleLabel.font = UIFont(name:"Helvetica", size:21)
    navigationController?.navigationBar.setGradientBackground(colors: colors)
    navigationItem.titleView = titleLabel
    
  }
  func closeGeneralButton() {
    self.generalButtonView.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
    self.generalButtonView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    self.generalButtonView.layer.shadowRadius = 0
    self.generalButtonView.layer.shadowOpacity = 0
  }
  func openGeneralButton() {
    self.generalButtonView.backgroundColor = .white
    self.generalButtonView.layer.shadowOffset = CGSize(width: 0.5, height: -1.0)
    self.generalButtonView.layer.shadowRadius = 1.5
    self.generalButtonView.layer.shadowOpacity = 0.2
  }
  func closeExchangesButton() {
    self.exchangesButtonView.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
    self.exchangesButtonView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    self.exchangesButtonView.layer.shadowRadius = 0
    self.exchangesButtonView.layer.shadowOpacity = 0
  }
  func openExchangesButton() {
    self.exchangesButtonView.backgroundColor = .white
    self.exchangesButtonView.layer.shadowOffset = CGSize(width: 0.5, height: -1.0)
    self.exchangesButtonView.layer.shadowRadius = 1.5
    self.exchangesButtonView.layer.shadowOpacity = 0.2
  }
  func closeAlertsButton() {
    self.alertsButtonView.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
    self.alertsButtonView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    self.alertsButtonView.layer.shadowRadius = 0
    self.alertsButtonView.layer.shadowOpacity = 0
  }
  func openAlertsButton() {
    self.alertsButtonView.backgroundColor = .white
    self.alertsButtonView.layer.shadowOffset = CGSize(width: 0.5, height: -1.0)
    self.alertsButtonView.layer.shadowRadius = 1.5
    self.alertsButtonView.layer.shadowOpacity = 0.2
  }
  
  func setupSettingsBarGestures() {
    
    let generalButtonGesture = UITapGestureRecognizer(target: self, action:  #selector (generalAction (_:)))
    
    let alertsButtonGesture = UITapGestureRecognizer(target: self, action:  #selector (alertsAction (_:)))
    
    let exchangesButtonGesture = UITapGestureRecognizer(target: self, action:  #selector (exchangesAction (_:)))
    
    self.generalButtonView.addGestureRecognizer(generalButtonGesture)
    self.exchangesButtonView.addGestureRecognizer(exchangesButtonGesture)
    self.alertsButtonView.addGestureRecognizer(alertsButtonGesture)
  }
  
  func setupLanguageGestured() {
    let languageButtonGesture = UITapGestureRecognizer(target: self, action:  #selector (languageAction (_:)))
    self.languageButtonView.addGestureRecognizer(languageButtonGesture)
  }
  
  @objc func languageAction(_ sender:UITapGestureRecognizer){
    print("languageAction")
    UIView.animate(withDuration: 0.1, animations: {
      self.languageButtonView.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)
    })
    UIView.animate(withDuration: 0.5, animations: {
      self.languageButtonView.backgroundColor = .white
    })
    let lenguageController = LanguageVC()
    navigationController?.pushViewController(lenguageController, animated: true)
  }
  
  @objc func generalAction(_ sender:UITapGestureRecognizer){
    print("General")
    openGeneralButton()
    closeAlertsButton()
    closeExchangesButton()
  }
  
  @objc func exchangesAction(_ sender:UITapGestureRecognizer){
    print("Exchanges")
    openExchangesButton()
    closeGeneralButton()
    closeAlertsButton()
  }
  
  @objc func alertsAction(_ sender:UITapGestureRecognizer){
    print("Alerst")
    openAlertsButton()
    closeGeneralButton()
    closeExchangesButton()
  }
  
}
