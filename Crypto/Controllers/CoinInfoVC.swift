//
//  DetailCoinVC.swift
//  Crypto
//
//  Created by Kaiserdem on 24.06.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit
import Charts

class CoinInfoVC: UIViewController {
  
  @IBOutlet weak var lineChartView: LineChartView!
  
  @IBOutlet weak var widthConstraintTopPtogresView: NSLayoutConstraint!
  @IBOutlet weak var widthConstraintpBackProgresView: NSLayoutConstraint!

  @IBOutlet weak var buttonBarUSD: UIView!
  @IBOutlet weak var buttonBarBTC: UIView!
  @IBOutlet weak var buttonBarKRW: UIView!
  @IBOutlet weak var buttonBarEUR: UIView!
  
  @IBOutlet weak var backBarCornerView: UIView!
  @IBOutlet weak var whiteBarView: UIView!
  @IBOutlet weak var iconImagevVew: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var symbolLabel: UILabel!
  @IBOutlet weak var rankLabel: UILabel!
  @IBOutlet weak var rankTitelDownLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var changeLabel: UILabel!
  @IBOutlet weak var maxPriceLabel: UILabel!
  @IBOutlet weak var minPriceLabel: UILabel!
  @IBOutlet weak var starWatchlistImageView: UIImageView!
  @IBOutlet weak var marcketcapLabel: UILabel!
  @IBOutlet weak var volume24Label: UILabel!
  @IBOutlet weak var circulatingLabel: UILabel!
  @IBOutlet weak var maxSupplyLabel: UILabel!
  @IBOutlet weak var topProgresView: UIView! // progress
  @IBOutlet weak var progressViewBack: UIView!
  @IBOutlet weak var topViewForShadow: UIView!
  @IBOutlet weak var dayTextView: UIView! // bar charts text
  @IBOutlet weak var weekTextView: UIView!
  @IBOutlet weak var monthTextView: UIView!
  @IBOutlet weak var yearTextView: UIView!
  @IBOutlet weak var twoYearsTextView: UIView!
  @IBOutlet weak var dayTopView: UIView! // bar charts top
  @IBOutlet weak var weekTopView: UIView!
  @IBOutlet weak var monthTopView: UIView!
  @IBOutlet weak var yearTopView: UIView!
  @IBOutlet weak var twoYearsTopView: UIView!
  
  var assets = [Assets]()
  var acceptAssets: [Assets] = []
  var data: [[Datum]]?
  
  var dayArray = [0.48674666,0.48679666,0.48671666,0.42674666,0.42697414,0.42930927,0.42750263,0.42768186,0.42625276,0.42632109,0.42681791,0.42513552,0.42204073,0.42450601,0.42602617,0.42510613,0.45721984,0.45419202,0.45925019,0.45842745,0.45964609,0.46630393,0.45762964,0.45578137,0.46369375,0.4699259,0.46414812,0.4658122,0.47700516,0.4690174,0.48044204,0.47068715,0.47356953,0.47741759,0.4730036,0.47595446,0.48082541,0.47600384,0.47603397,0.47905846,0.47174694,0.46534131,0.46907852,0.46421935,0.46749744,0.47083961,0.47206238,0.47446015,0.4735839,0.47193777,0.47268355,0.472165171652468]
  
  var weekArray = [8137.53475433,8173.81730219,8159.95489034,8158.76487186,8176.44112509,8202.57410367,8188.86389238,8199.34081446,8192.74608606,8204.96196211,8204.42997173,8229.72104774,8292.16544962,8287.96898507,8264.96241787,8269.77270989,8288.87325424,8303.89117593,8313.32332362,8296.23172464,8288.60888569,8260.96859225,8265.74223506,8253.64131446,8245.88894048,8220.3366843,8210.72817652,8220.47534595,8218.10926692,8232.42765951,8229.59977264,8228.87080434,8257.42081649,8266.37337488,8242.57644615,8223.79682864,8242.14281472,8266.91620923,8279.61001316,8313.80990696,8304.34707718,8289.37028197,8319.75631896,8303.41368657,8306.60372722,8305.37850765,8297.30065304,8355.68658443,8381.9484228]
  
  var mounthArray = [0.12682521,0.12737884,0.1270918,0.12698418,0.12705146,0.12721924,0.12683648,0.12720217,0.1270906,0.12677809,0.12595337,0.12630259,0.12632589,0.12550384,0.12541846,0.12563567,0.12581302,0.12589596,0.12555299,0.12566571,0.12532643,0.12504278,0.12478676,0.1250939,0.12459661,0.12427484,0.12369373,0.1239024,0.12391089,0.12410331,0.12401263,0.12398984,0.12433832,0.12464303,0.12448232,0.12411888,0.12418276,0.12408269,0.1239014,0.12444734,0.12428958,0.12370714,0.1238706,0.12326953,0.12292249,0.12244172,0.12179684,0.1214836,0.12235428]
  
  var yearArray = [0.439666,0.44382635,0.44422432,0.44323547,0.44455257,0.44557715,0.44571173,0.44347716,0.44303486,0.44282348,0.44039067,0.44664028,0.44750339,0.44515055,0.44417513,0.44434329,0.44611942,0.44806858,0.44768048,0.44522708,0.44207249,0.44093802,0.44091733,0.44054924,0.43986865,0.43597457,0.43457925,0.43437798,0.43495295,0.43601284,0.43405426,0.43492766,0.43770214,0.43852762,0.43755837,0.43638212,0.43472351,0.43627543,0.43649697,0.43924718,0.43684361,0.43484934,0.43637773,0.43634812,0.43611547,0.43499135,0.43143865,0.42541405,0.42678604]
  
  var twoYaear = [1.27549393,1.27712613,1.27566997,1.27514624,1.2746762,1.28112849,1.28999177,1.26663763,1.27006372,1.27391677,1.26691584,1.26549962,1.27770143,1.2771141,1.27788688,1.26926234,1.27559462,1.27009021,1.27390638,1.27162576,1.27533023,1.27239085,1.27260979,1.27335682,1.27762179,1.2710722,1.26473863,1.26564634,1.2692724,1.26505289,1.26501707,1.26413625,1.27134201,1.27076196,1.25489526,1.25026693,1.25133614,1.25031973,1.24753916,1.2502254,1.2449878,1.24250021,1.24225998,1.2410615,1.24044813,1.22781291,1.23068477,1.22794466,1.23755407]

  override func viewDidLoad() {
    super.viewDidLoad()

    setLineChart(values: dayArray)
    
    let maxPrice = self.dayArray.max()?.rounded(toPlaces: 2)
    self.maxPriceLabel.text = String(describing: maxPrice!)
    
    let minPrice = self.dayArray.min()?.rounded(toPlaces: 2)
    self.maxPriceLabel.text = String(describing: minPrice!)
    
  //  fetchAssets()
    fetchSparklineData()
    updateAssets()
    setupNavBarSettings()
    setupBarViewSettings()
    setupTopBarButtonSettings()
    openUSDButtonBar()
    setupChartsTopBarSettings()
    progressBar()
  }
 
  
  func updateAssets() {
    
    for i in acceptAssets {
      
      let price = i.price
      let priceDouble = Double((10*price!).rounded()/10000).rounded(toPlaces: 2)
//      if i.id != "bitcoin" {
//        self.priceLabel.text = String(describing: priceDouble) + "K"
//      }
      self.priceLabel.text = String(describing: priceDouble)

      let title = i.title
      self.titleLabel.text = title
      
      let change = i.change
      let changeDouble = change!.rounded(toPlaces: 2)
      self.changeLabel.text = String(describing: changeDouble) + "%"
      
      let rank = i.rank
      self.rankLabel.text = String(describing: rank!)
      
      let volume24 = i.volume24
      let volume24Double = Double((1*volume24!).rounded()/1000000000).rounded(toPlaces: 1)
      self.volume24Label.text = "$" + String(describing: volume24Double) + "B"
      
      let marketcap = i.marketcap
      let marketcapDouble = Double((1*marketcap!).rounded()/1000000000).rounded(toPlaces: 1)
      self.marcketcapLabel.text = "$" + String(describing: marketcapDouble) + "B"
  
      let symbol = i.symbol
      self.symbolLabel.text = String(describing: symbol!)
      
      let circulating = i.circulating
      let circulatingDouble = Double((1*circulating!).rounded()/1000000).rounded(toPlaces: 1)
      self.circulatingLabel.text = String(describing: circulatingDouble) + "M BTC"
      
      let maxSupply = i.maxSupply
      let maxSupplyDouble = Double((1*maxSupply!).rounded()/1000000).rounded(toPlaces: 1)
      self.maxSupplyLabel.text = String(describing: maxSupplyDouble) + "M BTC"
      
      self.progressViewBack.backgroundColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
      self.topProgresView.backgroundColor = #colorLiteral(red: 0.451000005, green: 0.6859999895, blue: 0.1490000039, alpha: 1)
      
    }
  }
  func progressBar() {
    for i in self.acceptAssets {
      if i.maxSupply?.isZero == false  {     // && i.circulating != nil
        let oneWidthBack = (widthConstraintpBackProgresView.constant / CGFloat(i.maxSupply!))
        let newWidthTop = (oneWidthBack * CGFloat(i.circulating!))
        self.widthConstraintTopPtogresView.constant = newWidthTop
      } else {
        progressViewBack.isHidden = true
        topProgresView.isHidden = true
      }
    }
  }
  //print("\(widthConstraintTopPtogresView!) -> \(oneWidthTop)")
  //print(i.circulating)
//  func fetchAssets() {
//    AssetsApiWebSocket.sharedInstance.fetchAssets { [weak self] (assetsArray: [Assets]?) in
//      guard let strongSelf = self else { return }
//      strongSelf.assets = assetsArray!
//      for i in assetsArray! {
//        if i.id == self!.itemId {
//          let price = i.price
//          let double = price!.rounded(toPlaces: 1)
//          self!.priceLabel.text = String(describing: double)
//
//          let title = i.title
//          self!.titleLabel.text = title
//
//          let change = i.change
//          let changeDouble = change!.rounded(toPlaces: 2)
//          self!.changeLabel.text = String(describing: changeDouble) + "%"
//
//          let rank = i.rank
//          self!.rankLabel.text = String(describing: rank!)
//
//          let volume24 = i.volume24
//          let volume24Double = volume24!.rounded(toPlaces: 2)
//          self!.volume24Label.text = "$" + String(describing: volume24Double) + "B"
//
//          let marketcap = i.marketcap
//          let marketcapDouble = marketcap!.rounded(toPlaces: 2)
//          self!.marcketcapLabel.text = "$" + String(describing: marketcapDouble) + "B"
//
//          let symbol = i.symbol
//          self!.symbolLabel.text = String(describing: symbol!)
//
//          let maxSupply = i.maxSupply
//          let maxSupplyDouble = maxSupply!.rounded(toPlaces: 2)
//          self!.maxSupplyLabel.text = String(describing: maxSupplyDouble) + "M BTC"
//
//          let circulating = i.circulating
//          let circulatingDouble = circulating!.rounded(toPlaces: 2)
//          self!.circulatingLabel.text = String(describing: circulatingDouble) + "M BTC"
//        }
//      }
//    }
//  }
  func fetchSparklineData() {
    SparklineApiWebSocket.sharedInstance.fetchWebSocketSparkline { [weak self] (dataSparklineArray: [[Datum]]?) in
      guard let  strongSelf = self else  { return }
      strongSelf.data = dataSparklineArray
      for i in (self?.data)! {
        let id = i.first
        if id.debugDescription == self!.acceptAssets.first?.id {
          print("hello")
        }
      }
      
//      for i in [dataSparklineArray] { // 1219 масивов
//        let chartArray = i?.first //3 елемента  две строки и масив даблов
//        let id = chartArray?.first // беру строку
//        if id.debugDescription == self!.acceptAssets.first?.id { // выходит из цыкла, дальше не проверяет
//        }
//      }
    }
  }
  
  func setupTopBarButtonSettings() {
    
    let buttonBarUSDGesture = UITapGestureRecognizer(target: self, action:  #selector (buttonBarUSDAction (_:)))
    self.buttonBarUSD.layer.cornerRadius = 6
    
    let buttonBarBTCGesture = UITapGestureRecognizer(target: self, action:  #selector (buttonBarBTCAction (_:)))
    self.buttonBarBTC.layer.cornerRadius = 6
    
    let buttonBarKRWGesture = UITapGestureRecognizer(target: self, action:  #selector (buttonBarKRWAction (_:)))
    self.buttonBarKRW.layer.cornerRadius = 6
    
    let buttonBarEURGesture = UITapGestureRecognizer(target: self, action:  #selector (buttonBarEURAction (_:)))
    self.buttonBarEUR.layer.cornerRadius = 6
    
    self.buttonBarUSD.addGestureRecognizer(buttonBarUSDGesture)
    self.buttonBarBTC.addGestureRecognizer(buttonBarBTCGesture)
    self.buttonBarKRW.addGestureRecognizer(buttonBarKRWGesture)
    self.buttonBarEUR.addGestureRecognizer(buttonBarEURGesture)
  }
  
  func openUSDButtonBar() {
    self.buttonBarUSD.backgroundColor = .white
    self.buttonBarUSD.layer.shadowOffset = CGSize(width: 0.5, height: -1.0)
    self.buttonBarUSD.layer.shadowRadius = 1.5
    self.buttonBarUSD.layer.shadowOpacity = 0.1
  }
  func closeUSDButtonBar() {
    self.buttonBarUSD.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
    self.buttonBarUSD.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    self.buttonBarUSD.layer.shadowRadius = 0
    self.buttonBarUSD.layer.shadowOpacity = 0
  }
  func openBTCButtonBar() {
    self.buttonBarBTC.backgroundColor = .white
    self.buttonBarBTC.layer.shadowOffset = CGSize(width: 0.5, height: -1.0)
    self.buttonBarBTC.layer.shadowRadius = 1.5
    self.buttonBarBTC.layer.shadowOpacity = 0.1
  }
  func closeBTCButtonBar() {
    self.buttonBarBTC.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
    self.buttonBarBTC.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    self.buttonBarBTC.layer.shadowRadius = 0
    self.buttonBarBTC.layer.shadowOpacity = 0
  }
  func openEURButtonBar() {
    self.buttonBarEUR.backgroundColor = .white
    self.buttonBarEUR.layer.shadowOffset = CGSize(width: 0.5, height: -1.0)
    self.buttonBarEUR.layer.shadowRadius = 1.5
    self.buttonBarEUR.layer.shadowOpacity = 0.1
  }
  func closeEURButtonBar() {
    self.buttonBarEUR.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
    self.buttonBarEUR.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    self.buttonBarEUR.layer.shadowRadius = 0
    self.buttonBarEUR.layer.shadowOpacity = 0
  }
  func openKRWButtonBar() {
    self.buttonBarKRW.backgroundColor = .white
    self.buttonBarKRW.layer.shadowOffset = CGSize(width: 0.5, height: -1.0)
    self.buttonBarKRW.layer.shadowRadius = 1.5
    self.buttonBarKRW.layer.shadowOpacity = 0.1
  }
  func closeKRWButtonBar() {
    self.buttonBarKRW.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
    self.buttonBarKRW.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    self.buttonBarKRW.layer.shadowRadius = 0
    self.buttonBarKRW.layer.shadowOpacity = 0
  }
  
  @objc func buttonBarUSDAction(_ sender:UITapGestureRecognizer){
    openUSDButtonBar()
    closeBTCButtonBar()
    closeEURButtonBar()
    closeKRWButtonBar()
    let data = ["USD", "USD", "USD", "USD", "USD", "USD", "USD", "USD", "USD", "USD"]
    (self.children[0] as? CoinInfoTableVC)?.modelArray = data
    (self.children[0] as? CoinInfoTableVC)?.tableView.reloadData()
  }
  @objc func buttonBarBTCAction(_ sender:UITapGestureRecognizer){
    openBTCButtonBar()
    closeKRWButtonBar()
    closeUSDButtonBar()
    closeEURButtonBar()
    let data = ["BTC", "BTC", "BTC", "BTC", "BTC", "BTC", "BTC", "BTC", "BTC", "BTC","BTC", "BTC", "BTC", "BTC", "BTC", "BTC"]
    (self.children[0] as? CoinInfoTableVC)?.modelArray = data
    (self.children[0] as? CoinInfoTableVC)?.tableView.reloadData()
  }
  @objc func buttonBarKRWAction(_ sender:UITapGestureRecognizer){
    openKRWButtonBar()
    closeUSDButtonBar()
    closeEURButtonBar()
    closeBTCButtonBar()
    let data = ["KRW", "KRW", "KRW", "KRW", "KRW", "KRW", "KRW", "KRW", "KRW", "KRW","KRW", "KRW", "KRW", "KRW", "KRW", "KRW","KRW", "KRW", "KRW", "KRW", "KRW", "KRW"]
    (self.children[0] as? CoinInfoTableVC)?.modelArray = data
    (self.children[0] as? CoinInfoTableVC)?.tableView.reloadData()
  }
  @objc func buttonBarEURAction(_ sender:UITapGestureRecognizer){
    openEURButtonBar()
    closeUSDButtonBar()
    closeBTCButtonBar()
    closeKRWButtonBar()
    let data = ["EUR", "EUR", "EUR", "EUR", "EUR", "EUR", "EUR"]
    (self.children[0] as? CoinInfoTableVC)?.modelArray = data
    (self.children[0] as? CoinInfoTableVC)?.tableView.reloadData()
  }
  
  private func setupBarViewSettings() {
    
    topViewForShadow.layer.shadowOffset = CGSize(width: 0.0, height: -2.0)
    topViewForShadow.layer.cornerRadius = 8
    topViewForShadow.layer.shadowRadius = 1.5
    topViewForShadow.layer.shadowOpacity = 0.1

    topProgresView.layer.cornerRadius = 2
    progressViewBack.layer.cornerRadius = 2

    backBarCornerView.layer.cornerRadius = 8
    whiteBarView.layer.cornerRadius = 8
    whiteBarView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    whiteBarView.layer.shadowRadius = 1.5
    whiteBarView.layer.shadowOpacity = 0.1
  }
  private func setupNavBarSettings() {
    let titleLabel = UILabel(frame: CGRect(x: view.center.x, y: view.center.y, width: 0, height:0))
    titleLabel.text = "Coin Info"
    titleLabel.textColor = UIColor.white
    titleLabel.font = UIFont(name:"Helvetica", size:21)
    
    navigationItem.titleView = titleLabel
    
    let colors: [UIColor] = [#colorLiteral(red: 0, green: 0.7960784314, blue: 0.7921568627, alpha: 1), #colorLiteral(red: 0.4509803922, green: 0.6862745098, blue: 0.1490196078, alpha: 1)]
    navigationController?.navigationBar.setGradientBackground(colors: colors)
    navigationController?.navigationBar.barTintColor = .clear
    
    self.navigationController?.navigationBar.topItem?.title = ""
    self.navigationController?.navigationBar.tintColor = UIColor.white
  }
  
  func setLineChart(values: [Double]) {
    
    var dataEntries: [ChartDataEntry] = []
    
    for i in 0..<values.count {
      let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
      dataEntries.append(dataEntry)
    }
    let line = LineChartDataSet(values: dataEntries, label: "")
    line.colors = [#colorLiteral(red: 0.4509803922, green: 0.6862745098, blue: 0.1490196078, alpha: 1)]
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
  
  func setupChartsTopBarSettings() {
    
    let dayTextViewGesture = UITapGestureRecognizer(target: self, action:  #selector (dayAction (_:)))
    let weekTextViewGesture = UITapGestureRecognizer(target: self, action:  #selector (weekAction (_:)))
    let monthTextViewGesture = UITapGestureRecognizer(target: self, action:  #selector (monthAction (_:)))
    let yearTopViewGesture = UITapGestureRecognizer(target: self, action:  #selector (yearAction (_:)))
    let twoYearsTopViewGesture = UITapGestureRecognizer(target: self, action:  #selector (twoYearsAction (_:)))

    self.dayTextView.addGestureRecognizer(dayTextViewGesture)
    self.weekTextView.addGestureRecognizer(weekTextViewGesture)
    self.monthTextView.addGestureRecognizer(monthTextViewGesture)
    self.yearTextView.addGestureRecognizer(yearTopViewGesture)
    self.twoYearsTextView.addGestureRecognizer(twoYearsTopViewGesture)
  }
  
  @objc func dayAction(_ sender:UITapGestureRecognizer){
    DispatchQueue.main.async {
      self.setLineChart(values: self.dayArray)
      
      let maxPrice = self.dayArray.max()?.rounded(toPlaces: 2)
      self.maxPriceLabel.text = String(describing: maxPrice!)
      
      let minPrice = self.dayArray.min()?.rounded(toPlaces: 2)
      self.maxPriceLabel.text = String(describing: minPrice!)
      
      self.dayTopView.backgroundColor = .black
      self.weekTopView.backgroundColor = .clear
      self.monthTopView.backgroundColor = .clear
      self.yearTopView.backgroundColor = .clear
      self.twoYearsTopView.backgroundColor = .clear
    }
  }
  @objc func weekAction(_ sender:UITapGestureRecognizer){
    DispatchQueue.main.async {
      self.setLineChart(values: self.weekArray)
      
      let maxPrice = self.weekArray.max()?.rounded(toPlaces: 2)
      self.maxPriceLabel.text = String(describing: maxPrice!)
      
      let minPrice = self.weekArray.min()?.rounded(toPlaces: 2)
      self.maxPriceLabel.text = String(describing: minPrice!)
      
    self.dayTopView.backgroundColor = .clear
    self.weekTopView.backgroundColor = .black
    self.monthTopView.backgroundColor = .clear
    self.yearTopView.backgroundColor = .clear
    self.twoYearsTopView.backgroundColor = .clear
    }
  }
  @objc func monthAction(_ sender:UITapGestureRecognizer){
    DispatchQueue.main.async {
      self.setLineChart(values: self.mounthArray)
      
      let maxPrice = self.mounthArray.max()?.rounded(toPlaces: 2)
      self.maxPriceLabel.text = String(describing: maxPrice!)
      
      let minPrice = self.mounthArray.min()?.rounded(toPlaces: 2)
      self.maxPriceLabel.text = String(describing: minPrice!)
      
    self.dayTopView.backgroundColor = .clear
    self.weekTopView.backgroundColor = .clear
    self.monthTopView.backgroundColor = .black
    self.yearTopView.backgroundColor = .clear
    self.twoYearsTopView.backgroundColor = .clear
    }
  }
  @objc func yearAction(_ sender:UITapGestureRecognizer){
    DispatchQueue.main.async {
      self.setLineChart(values: self.yearArray)
      
      let maxPrice = self.yearArray.max()?.rounded(toPlaces: 2)
      self.maxPriceLabel.text = String(describing: maxPrice!)
      
      let minPrice = self.yearArray.min()?.rounded(toPlaces: 2)
      self.maxPriceLabel.text = String(describing: minPrice!)
      
    self.dayTopView.backgroundColor = .clear
    self.weekTopView.backgroundColor = .clear
    self.monthTopView.backgroundColor = .clear
    self.yearTopView.backgroundColor = .black
    self.twoYearsTopView.backgroundColor = .clear
    }
  }
  @objc func twoYearsAction(_ sender:UITapGestureRecognizer){
    DispatchQueue.main.async {
      self.setLineChart(values: self.twoYaear)
      
      let maxPrice = self.twoYaear.max()?.rounded(toPlaces: 2)
      self.maxPriceLabel.text = String(describing: maxPrice!)
      
      let minPrice = self.twoYaear.min()?.rounded(toPlaces: 2)
      self.maxPriceLabel.text = String(describing: minPrice!)
      
    self.dayTopView.backgroundColor = .clear
    self.weekTopView.backgroundColor = .clear
    self.monthTopView.backgroundColor = .clear
    self.yearTopView.backgroundColor = .clear
    self.twoYearsTopView.backgroundColor = .black
    }
  }
  
}
