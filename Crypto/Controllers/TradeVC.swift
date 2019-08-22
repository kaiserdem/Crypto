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
  
  @IBOutlet weak var buyBTCWidthConstraint: NSLayoutConstraint!
  @IBOutlet weak var mainViewBar: UIView!
  @IBOutlet weak var barViewTopBlack: UIView!
  @IBOutlet weak var usdLabel: UILabel!
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
  
  @IBOutlet weak var offlineBarButton: UIBarButtonItem! 

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setLineChart(valueColor: true, values: [0.40148978,0.40160831,0.40042421,0.40115466,0.40192427,0.40295178,0.40065773,0.40287235,0.40219121,0.40210189,0.40188772,0.40248469,0.40451362,0.40299778,0.40348546,0.40368312,0.40348905,0.40260939,0.40409341,0.40429376,0.40336876,0.40184321,0.4017423,0.40128457,0.39952367,0.39859765,0.39752978,0.39630637,0.39670904,0.39728291,0.39773043,0.39675257,0.39775085,0.39977283,0.39935694,0.39934958,0.39969119,0.3975139,0.39857906,0.39960345,0.39915637,0.3989418,0.39928145,0.39907781,0.39989021,0.39867521,0.39717452,0.39659442,0.39856274])
    
    setupNavBarSettings()
    setupBuyBarGestures()
    setupChartsBarGestures()
    setupCornerRadiusAllViews()
    openButtonViewBuyBTC()
    closeButtonViewSellBTC()
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(hidenUiNotified),
                                           name: NSNotification.Name(rawValue: keyHidenUiNotification),
                                           object: nil)
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(showUINotified),
                                           name: NSNotification.Name(rawValue: keyShowUiNotification),
                                           object: nil)
    
  }
  
  @objc func hidenUiNotified() {
    mainViewBar.isHidden = true
    usdLabel.isHidden = true
    barViewTopBlack.isHidden = true
    lineChartView.isHidden = true
    maxPriceChartLabel.isHidden = true
    minPriceChartLabel.isHidden = true
    buttonViewBuyBTC.isUserInteractionEnabled = false
    buttonViewSellBTC.isUserInteractionEnabled = false
    
  }
  @objc func showUINotified() {
    mainViewBar.isHidden = false
    usdLabel.isHidden = false
    barViewTopBlack.isHidden = false
    lineChartView.isHidden = false
    maxPriceChartLabel.isHidden = false
    minPriceChartLabel.isHidden = false
    buttonViewBuyBTC.isUserInteractionEnabled = true
    buttonViewSellBTC.isUserInteractionEnabled = true
  }
  
  private func setupNavBarSettings() {
    let colors: [UIColor] = [#colorLiteral(red: 0, green: 0.7960784314, blue: 0.7921568627, alpha: 1), #colorLiteral(red: 0.4509803922, green: 0.6862745098, blue: 0.1490196078, alpha: 1)]
    let titleLabel = UILabel(frame: CGRect(x: view.center.x, y: view.center.y, width: 0, height:0))
    titleLabel.text = NSLocalizedString("Trade", comment: "Trade")
    titleLabel.textColor = UIColor.white
    titleLabel.font = UIFont(name:"Helvetica", size:21)
    navigationItem.titleView = titleLabel
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
    self.buttonViewBuyBTC.layer.shadowOpacity = 0.2
  }
  func openButtonViewSellBTC() {
    self.buttonViewSellBTC.backgroundColor = .white
    self.buttonViewSellBTC.layer.shadowOffset = CGSize(width: 0.5, height: -1.0)
    self.buttonViewSellBTC.layer.shadowRadius = 1.5
    self.buttonViewSellBTC.layer.shadowOpacity = 0.2
  }
  func closeButtonViewSellBTC() {
    self.buttonViewSellBTC.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
    self.buttonViewSellBTC.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    self.buttonViewSellBTC.layer.shadowRadius = 0
    self.buttonViewSellBTC.layer.shadowOpacity = 0
  }
  func setupCornerRadiusAllViews() {
    backTopGrayView.layer.cornerRadius = 8
    whiteViewForChart.layer.cornerRadius = 8
    secondGrayView.layer.cornerRadius = 8
    buttonViewBuyBTC.layer.cornerRadius = 6
    buttonViewSellBTC.layer.cornerRadius = 6
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
    
    dayTextView.addGestureRecognizer(dayTextViewGesture)
    weekTextView.addGestureRecognizer(weekTextViewGesture)
    monthTextView.addGestureRecognizer(monthTextViewGesture)
    yearTextView.addGestureRecognizer(yearTopViewGesture)
  }
  
  @objc func dayAction(_ sender:UITapGestureRecognizer){
    dayTopView.backgroundColor = .black
    weekTopView.backgroundColor = .clear
    monthTopView.backgroundColor = .clear
    yearTopView.backgroundColor = .clear
  }
  @objc func weekAction(_ sender:UITapGestureRecognizer){
    dayTopView.backgroundColor = .clear
    weekTopView.backgroundColor = .black
    monthTopView.backgroundColor = .clear
    yearTopView.backgroundColor = .clear
  }
  @objc func monthAction(_ sender:UITapGestureRecognizer){
    dayTopView.backgroundColor = .clear
    weekTopView.backgroundColor = .clear
    monthTopView.backgroundColor = .black
    yearTopView.backgroundColor = .clear
  }
  @objc func yearAction(_ sender:UITapGestureRecognizer){
    dayTopView.backgroundColor = .clear
    weekTopView.backgroundColor = .clear
    monthTopView.backgroundColor = .clear
    yearTopView.backgroundColor = .black
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
  
  func setLineChart(valueColor: Bool, values: [Double]) {
    
    var dataEntries: [ChartDataEntry] = []
    
    for i in 0..<values.count {
      let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
      dataEntries.append(dataEntry)
    }
    let line = LineChartDataSet(values: dataEntries, label: "")
    
    switch valueColor {
    case true:
      line.colors = [#colorLiteral(red: 0.4509803922, green: 0.6862745098, blue: 0.1490196078, alpha: 1)]
    case false:
      line.colors = [#colorLiteral(red: 0.9725490196, green: 0.5058823529, blue: 0.3960784314, alpha: 1)]
    }
    line.mode = .linear // стиль линии
    line.cubicIntensity = 3.9 // интенсивность
    line.drawCirclesEnabled = false // убрать круги на пиках
    line.lineWidth = 2
    
    let data = LineChartData()
    data.addDataSet(line)
    data.setValueFont(NSUIFont(name: "", size: 0))
    
    lineChartView.data = data
    lineChartView.setScaleEnabled(false)
    lineChartView.animate(xAxisDuration: 0.0)
    lineChartView.drawGridBackgroundEnabled = false
    lineChartView.xAxis.drawAxisLineEnabled = false
    lineChartView.xAxis.drawGridLinesEnabled = false
    lineChartView.leftAxis.drawAxisLineEnabled = false
    lineChartView.leftAxis.drawGridLinesEnabled = false
    lineChartView.rightAxis.drawAxisLineEnabled = false
    lineChartView.rightAxis.drawGridLinesEnabled = false
    lineChartView.legend.enabled = false
    lineChartView.xAxis.enabled = false
    lineChartView.leftAxis.enabled = false
    lineChartView.rightAxis.enabled = false
    lineChartView.xAxis.drawLabelsEnabled = false
    
  }
}

