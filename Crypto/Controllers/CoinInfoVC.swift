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
  var dataItem: ItemSparklineModel?
  var dataArrayEmpty: [NSMutableArray] = []
  
  var chartDayArray = [NSNumber]()
  var chartWeekArray = [NSNumber]()
  var chartMounthArray = [NSNumber]()
  var chartYearArray = [NSNumber]()
  var chartTwoYaearArray = [NSNumber]()
  
  var imageDictionary = ["bitcoin": UIImage(named: "bitcoin"),
                         "ethereum": UIImage(named: "ethereum"),
                         "ripple": UIImage(named: "ripple"),
                         "litecoin": UIImage(named: "litecoin"),
                         "bitcoin-cash": UIImage(named: "bitcoin-cash"),
                         "eos": UIImage(named: "eos"),
                         "binance-coin": UIImage(named: "binance-coin"),
                         "tether": UIImage(named: "tether"),
                         "bitcoin-sv": UIImage(named: "bitcoin-sv"),
                         "tron": UIImage(named: "tron"),
                         "stellar": UIImage(named: "stellar"),
                         "cardano": UIImage(named: "cardano"),
                         "monero": UIImage(named: "monero"),
                         "dash": UIImage(named: "dash"),
                         "cosmos": UIImage(named: "cosmos"),
                         "chainlink": UIImage(named: "chainlink"),
                         "neo": UIImage(named: "neo"),
                         "iota": UIImage(named: "iota"),
                         "ethereum-classic": UIImage(named: "ethereum-classic")]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //  fetchAssets()
    fetchSparklineItem()
    updateAssets()
    setupNavBarSettings()
    setupBarViewSettings()
    setupTopBarButtonSettings()
    openUSDButtonBar()
    setupChartsBarGestures()
    progressBar()
  }
  
  func updateAssets() {
    
    for i in acceptAssets {
      
      let id  = i.id
      for (key, value) in imageDictionary {
        if key == id {
          self.iconImagevVew.image = value
        }
      }
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
        maxSupplyLabel.text = NSLocalizedString("Unlimited", comment: "Unlimited")
      }
    }
  }
  func fetchSparklineItem() {

    var itemId = ""
    for i in acceptAssets {
      itemId = i.id!
    }
    SparklineItemApiWebSocket.sharedInstance.fetchWebSocketAllSparkline(id: itemId) { [weak self] (dataSparklineArray: ItemSparklineModel?) in
    
      guard let  strongSelf = self else  { return }
      strongSelf.dataItem = dataSparklineArray
      
      for i1 in (dataSparklineArray?.data ?? self!.dataArrayEmpty) {
        if (((i1[1] as? NSString)?.isEqual(to: "d"))!) {
          let doubleArray = i1.lastObject
          self!.chartDayArray = doubleArray as! [NSNumber]
          
          self!.setLineChart(values: self!.chartDayArray as! [Double])
          
          let maxPrice = self!.chartDayArray as! [Double]
          self!.maxPriceLabel.text = String(describing:(maxPrice.max()!.rounded(toPlaces: 2)))
          
          let minPrice = self!.chartDayArray as! [Double]
          self!.minPriceLabel.text = String(describing:(minPrice.min()!.rounded(toPlaces: 2)))
          
        } else if (((i1[1] as? NSString)?.isEqual(to: "w"))!) {
          let doubleArray = i1.lastObject
          self!.chartWeekArray = doubleArray as! [NSNumber]
          
        } else if (((i1[1] as? NSString)?.isEqual(to: "m"))!) {
          let doubleArray = i1.lastObject
          self!.chartMounthArray = doubleArray as! [NSNumber]
          
        } else if (((i1[1] as? NSString)?.isEqual(to: "y"))!) {
          let doubleArray = i1.lastObject
          self!.chartYearArray = doubleArray as! [NSNumber]
          
        } else if (((i1[1] as? NSString)?.isEqual(to: "Y"))!) {
          let doubleArray = i1.lastObject
          self!.chartTwoYaearArray = doubleArray as! [NSNumber]
        }
      }
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
    titleLabel.text = NSLocalizedString("Coin Info", comment: "Coin Info")
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
    lineChartView.noDataText = "dsfvdsv"
    lineChartView.noDataTextColor = UIColor.blue
    
  }
  
  func setupChartsBarGestures() {
    
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
      if self.chartDayArray.isEmpty != true {
      self.setLineChart(values: self.chartDayArray as! [Double])
        
      let maxPrice = self.chartDayArray as! [Double]
      self.maxPriceLabel.text = String(describing:(maxPrice.max()!.rounded(toPlaces: 2)))
      
      let minPrice = self.chartDayArray as! [Double]
      self.minPriceLabel.text = String(describing:(minPrice.min()!.rounded(toPlaces: 2)))
      }
      self.dayTopView.backgroundColor = .black
      self.weekTopView.backgroundColor = .clear
      self.monthTopView.backgroundColor = .clear
      self.yearTopView.backgroundColor = .clear
      self.twoYearsTopView.backgroundColor = .clear
    }
  }
  @objc func weekAction(_ sender:UITapGestureRecognizer){
    DispatchQueue.main.async {
      if self.chartDayArray.isEmpty != true {
      self.setLineChart(values: self.chartWeekArray as! [Double])
      
      let maxPrice = self.chartWeekArray as! [Double]
      self.maxPriceLabel.text = String(describing:(maxPrice.max()!.rounded(toPlaces: 2)))
      
      let minPrice = self.chartWeekArray as! [Double]
      self.minPriceLabel.text = String(describing:(minPrice.min()!.rounded(toPlaces: 2)))
      }
      self.dayTopView.backgroundColor = .clear
      self.weekTopView.backgroundColor = .black
      self.monthTopView.backgroundColor = .clear
      self.yearTopView.backgroundColor = .clear
      self.twoYearsTopView.backgroundColor = .clear
    }
  }
  @objc func monthAction(_ sender:UITapGestureRecognizer){
    DispatchQueue.main.async {
      if self.chartDayArray.isEmpty != true {
      self.setLineChart(values: self.chartMounthArray as! [Double])
      
      let maxPrice = self.chartMounthArray as! [Double]
      self.maxPriceLabel.text = String(describing:(maxPrice.max()!.rounded(toPlaces: 2)))
      
      let minPrice = self.chartMounthArray as! [Double]
      self.minPriceLabel.text = String(describing:(minPrice.min()!.rounded(toPlaces: 2)))
      }
      self.dayTopView.backgroundColor = .clear
      self.weekTopView.backgroundColor = .clear
      self.monthTopView.backgroundColor = .black
      self.yearTopView.backgroundColor = .clear
      self.twoYearsTopView.backgroundColor = .clear
    }
  }
  @objc func yearAction(_ sender:UITapGestureRecognizer){
    DispatchQueue.main.async {
      if self.chartDayArray.isEmpty != true {
      self.setLineChart(values: self.chartYearArray as! [Double])
        
      let maxPrice = self.chartYearArray as! [Double]
      self.maxPriceLabel.text = String(describing:(maxPrice.max()!.rounded(toPlaces: 2)))
      
      let minPrice = self.chartYearArray as! [Double]
      self.minPriceLabel.text = String(describing:(minPrice.min()!.rounded(toPlaces: 2)))
      }
      self.dayTopView.backgroundColor = .clear
      self.weekTopView.backgroundColor = .clear
      self.monthTopView.backgroundColor = .clear
      self.yearTopView.backgroundColor = .black
      self.twoYearsTopView.backgroundColor = .clear
    }
  }
  @objc func twoYearsAction(_ sender:UITapGestureRecognizer){
    DispatchQueue.main.async {
      if self.chartDayArray.isEmpty != true {
      self.setLineChart(values: self.chartTwoYaearArray as! [Double])
    
      let maxPrice = (self.chartTwoYaearArray as! [Double])
      self.maxPriceLabel.text = String(describing:(maxPrice.max()!.rounded(toPlaces: 2)))
      
      let minPrice = self.chartTwoYaearArray as! [Double]
      self.minPriceLabel.text = String(describing:(minPrice.min()!.rounded(toPlaces: 2)))
      }
      self.dayTopView.backgroundColor = .clear
      self.weekTopView.backgroundColor = .clear
      self.monthTopView.backgroundColor = .clear
      self.yearTopView.backgroundColor = .clear
      self.twoYearsTopView.backgroundColor = .black
    }
  }
}
