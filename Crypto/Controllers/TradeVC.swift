//
//  TradeVC.swift
//  Crypto
//
//  Created by Kaiserdem on 19.06.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit
import Charts

class TradeVC: UIViewController {

  @IBOutlet weak var sellConteinerView: UIView!
  @IBOutlet weak var buyConteinerView: UIView!
  @IBOutlet weak var secondGrayView: UIView!
  @IBOutlet weak var whiteViewForChart: UIView!
  @IBOutlet weak var backTopGrayView: UIView!

  @IBOutlet weak var buttonViewBuyBTC: UIView!
  
  @IBOutlet weak var labelButtonBuyBTC: UILabel!
  
  @IBOutlet weak var buttonViewSellBTC: UIView!
  
  @IBOutlet weak var labelButonSellBTC: UILabel!
  
  @IBOutlet weak var lineChartView: LineChartView!
  
  @IBOutlet weak var rightLabelUSD: UILabel!
  @IBOutlet weak var rightLabelBTC: UILabel!
  
  @IBOutlet weak var lastPriceLabel: UILabel!
  
  @IBOutlet weak var maxPriceChartLabel: UILabel!
  @IBOutlet weak var minPriceChartLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  
  @IBOutlet weak var dayTextView: UIView! // bar charts text
  @IBOutlet weak var weekTextView: UIView!
  @IBOutlet weak var monthTextView: UIView!
  @IBOutlet weak var yearTextView: UIView!
  
  @IBOutlet weak var dayTopView: UIView! // bar charts top
  @IBOutlet weak var weekTopView: UIView!
  @IBOutlet weak var monthTopView: UIView!
  @IBOutlet weak var yearTopView: UIView!
  
  
  
  override func viewDidLoad() {
        super.viewDidLoad()

    setupNavBarSettings()
    setupBuyBarGestures()
    setupChartsBarGestures()
    openButtonViewBuyBTC()
    closeButtonViewSellBTC()
    
    
    
    backTopGrayView.layer.cornerRadius = 8
    whiteViewForChart.layer.cornerRadius = 8
    secondGrayView.layer.cornerRadius = 8
    buttonViewBuyBTC.layer.cornerRadius = 6
    buttonViewSellBTC.layer.cornerRadius = 6
    
  }
    
  private func setupNavBarSettings() {
    let colors: [UIColor] = [#colorLiteral(red: 0, green: 0.7960784314, blue: 0.7921568627, alpha: 1), #colorLiteral(red: 0.4509803922, green: 0.6862745098, blue: 0.1490196078, alpha: 1)]
    let titleLabel = UILabel(frame: CGRect(x: view.center.x, y: view.center.y, width: 0, height:0))
    titleLabel.text = "Trade"
    titleLabel.textColor = UIColor.white
    titleLabel.font = UIFont(name:"Helvetica", size:21)
    
    navigationController?.navigationBar.setGradientBackground(colors: colors)
  }
  func closeButtonViewBuyBTC() {
    self.buttonViewBuyBTC.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
    self.buttonViewBuyBTC.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    self.buttonViewBuyBTC.layer.shadowRadius = 0
    self.buttonViewBuyBTC.layer.shadowOpacity = 0
  }
  func openButtonViewBuyBTC() {
    self.buttonViewBuyBTC.backgroundColor = .white
    self.buttonViewBuyBTC.layer.shadowOffset = CGSize(width: 0.5, height: -1.0)
    self.buttonViewBuyBTC.layer.shadowRadius = 1.5
    self.buttonViewBuyBTC.layer.shadowOpacity = 0.1
  }
  func openButtonViewSellBTC() {
    self.buttonViewSellBTC.backgroundColor = .white
    self.buttonViewSellBTC.layer.shadowOffset = CGSize(width: 0.5, height: -1.0)
    self.buttonViewSellBTC.layer.shadowRadius = 1.5
    self.buttonViewSellBTC.layer.shadowOpacity = 0.1
  }
  func closeButtonViewSellBTC() {
    self.buttonViewSellBTC.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
    self.buttonViewSellBTC.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    self.buttonViewSellBTC.layer.shadowRadius = 0
    self.buttonViewSellBTC.layer.shadowOpacity = 0
  }
  
  func setupBuyBarGestures() {
    
    let buttonViewBuyBTCGesture = UITapGestureRecognizer(target: self, action:  #selector (buttonViewBuyBTCAction (_:)))
    self.buttonViewBuyBTC.layer.cornerRadius = 6
    
    let buttonViewSellBTCGesture = UITapGestureRecognizer(target: self, action:  #selector (buttonViewSellBTCAction (_:)))
    self.buttonViewSellBTC.layer.cornerRadius = 6
    
    
    self.buttonViewBuyBTC.addGestureRecognizer(buttonViewBuyBTCGesture)
    self.buttonViewSellBTC.addGestureRecognizer(buttonViewSellBTCGesture)
  }
  
  func setupChartsBarGestures() {

    let dayTextViewGesture = UITapGestureRecognizer(target: self, action:  #selector (dayAction (_:)))
    let weekTextViewGesture = UITapGestureRecognizer(target: self, action:  #selector (weekAction (_:)))
    let monthTextViewGesture = UITapGestureRecognizer(target: self, action:  #selector (monthAction (_:)))
    let yearTopViewGesture = UITapGestureRecognizer(target: self, action:  #selector (yearAction (_:)))
    
    self.dayTextView.addGestureRecognizer(dayTextViewGesture)
    self.weekTextView.addGestureRecognizer(weekTextViewGesture)
    self.monthTextView.addGestureRecognizer(monthTextViewGesture)
    self.yearTextView.addGestureRecognizer(yearTopViewGesture)
  }
  
  @objc func dayAction(_ sender:UITapGestureRecognizer){
    self.dayTopView.backgroundColor = .black
    self.weekTopView.backgroundColor = .clear
    self.monthTopView.backgroundColor = .clear
    self.yearTopView.backgroundColor = .clear
  }
  @objc func weekAction(_ sender:UITapGestureRecognizer){
    self.dayTopView.backgroundColor = .clear
    self.weekTopView.backgroundColor = .black
    self.monthTopView.backgroundColor = .clear
    self.yearTopView.backgroundColor = .clear
  }
  @objc func monthAction(_ sender:UITapGestureRecognizer){
    self.dayTopView.backgroundColor = .clear
    self.weekTopView.backgroundColor = .clear
    self.monthTopView.backgroundColor = .black
    self.yearTopView.backgroundColor = .clear
  }
  @objc func yearAction(_ sender:UITapGestureRecognizer){
    self.dayTopView.backgroundColor = .clear
    self.weekTopView.backgroundColor = .clear
    self.monthTopView.backgroundColor = .clear
    self.yearTopView.backgroundColor = .black
  }
  
  @objc func buttonViewBuyBTCAction(_ sender:UITapGestureRecognizer){
    print("Buy")
    buyConteinerView.isHidden = false
    sellConteinerView.isHidden = true
    openButtonViewBuyBTC()
    closeButtonViewSellBTC()
  }
  @objc func buttonViewSellBTCAction(_ sender:UITapGestureRecognizer){
    print("Sell")
    buyConteinerView.isHidden = true
    sellConteinerView.isHidden = false
    openButtonViewSellBTC()
    closeButtonViewBuyBTC()
  }
//  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//    super.viewWillTransition(to: size, with: coordinator)
//
//    if UIDevice.current.orientation.isLandscape {
//      viewTopConstraint.constant = -7
//    } else {
//      viewTopConstraint.constant = 0
//    }
//  }

}
