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
  @IBOutlet weak var topProgresView: UIView!
  @IBOutlet weak var progressViewBack: UIView!
  @IBOutlet weak var topViewForShadow: UIView!
  
  @IBOutlet weak var dayTextView: UIView!
  @IBOutlet weak var weekTextView: UIView!
  @IBOutlet weak var monthTextView: UIView!
  @IBOutlet weak var yearTextView: UIView!
  @IBOutlet weak var twoYearsTextView: UIView!
  
  @IBOutlet weak var dayTopView: UIView!
  @IBOutlet weak var weekTopView: UIView!
  @IBOutlet weak var monthTopView: UIView!
  @IBOutlet weak var yearTopView: UIView!
  @IBOutlet weak var twoYearsTopView: UIView!
  
  var assets = [Assets]()
  var acceptAssets: [Assets] = []
  var data: [[Datum]]?

  override func viewDidLoad() {
    super.viewDidLoad()

    setLineChart(values: [0.48674666,0.48679666,0.48671666,0.42674666,0.42697414,0.42930927,0.42750263,0.42768186,0.42625276,0.42632109,0.42681791,0.42513552,0.42204073,0.42450601,0.42602617,0.42510613,0.45721984,0.45419202,0.45925019,0.45842745,0.45964609,0.46630393,0.45762964,0.45578137,0.46369375,0.4699259,0.46414812,0.4658122,0.47700516,0.4690174,0.48044204,0.47068715,0.47356953,0.47741759,0.4730036,0.47595446,0.48082541,0.47600384,0.47603397,0.47905846,0.47174694,0.46534131,0.46907852,0.46421935,0.46749744,0.47083961,0.47206238,0.47446015,0.4735839,0.47193777,0.47268355,0.472165171652468])
    
  //  fetchAssets()
    fetchSparklineData()
    updateAssets()
    setupNavBarSettings()
    setupBarViewSettings()
    setupTopBarButtonSettings()
    openUSDButtonBar()
    setupChartsTopBarSettings()
  }
 
  func updateAssets() {
    for i in acceptAssets {
      
      let price = i.price
      let double = price!.rounded(toPlaces: 1)
      self.priceLabel.text = String(describing: double)
      
      let title = i.title
      self.titleLabel.text = title
      
      let change = i.change
      let changeDouble = change!.rounded(toPlaces: 2)
      self.changeLabel.text = String(describing: changeDouble) + "%"
      
      let rank = i.rank
      self.rankLabel.text = String(describing: rank!)
      
      let volume24 = i.volume24
      let volume24Double = volume24!.rounded(toPlaces: 2)
      self.volume24Label.text = "$" + String(describing: volume24Double) + "B"
      
      let marketcap = i.marketcap
      let marketcapDouble = marketcap!.rounded(toPlaces: 2)
      self.marcketcapLabel.text = "$" + String(describing: marketcapDouble) + "B"
      
      let symbol = i.symbol
      self.symbolLabel.text = String(describing: symbol!)
      
      let maxSupply = i.maxSupply
      let maxSupplyDouble = maxSupply!.rounded(toPlaces: 2)
      self.maxSupplyLabel.text = String(describing: maxSupplyDouble) + "M BTC"
      
      let circulating = i.circulating
      let circulatingDouble = circulating!.rounded(toPlaces: 2)
      self.circulatingLabel.text = String(describing: circulatingDouble) + "M BTC"
      
    }
  }
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
      for i in [dataSparklineArray] {
        let chartArray = i?.first
        let id = chartArray?.first
        if id.debugDescription == self!.acceptAssets.first?.id {
          
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
      self.dayTopView.backgroundColor = .black
      self.weekTopView.backgroundColor = .clear
      self.monthTopView.backgroundColor = .clear
      self.yearTopView.backgroundColor = .clear
      self.twoYearsTopView.backgroundColor = .clear
    }
  }
  @objc func weekAction(_ sender:UITapGestureRecognizer){
    DispatchQueue.main.async {
    self.dayTopView.backgroundColor = .clear
    self.weekTopView.backgroundColor = .black
    self.monthTopView.backgroundColor = .clear
    self.yearTopView.backgroundColor = .clear
    self.twoYearsTopView.backgroundColor = .clear
    }
  }
  @objc func monthAction(_ sender:UITapGestureRecognizer){
    DispatchQueue.main.async {
    self.dayTopView.backgroundColor = .clear
    self.weekTopView.backgroundColor = .clear
    self.monthTopView.backgroundColor = .black
    self.yearTopView.backgroundColor = .clear
    self.twoYearsTopView.backgroundColor = .clear
    }
  }
  @objc func yearAction(_ sender:UITapGestureRecognizer){
    DispatchQueue.main.async {
    self.dayTopView.backgroundColor = .clear
    self.weekTopView.backgroundColor = .clear
    self.monthTopView.backgroundColor = .clear
    self.yearTopView.backgroundColor = .black
    self.twoYearsTopView.backgroundColor = .clear
    }
  }
  @objc func twoYearsAction(_ sender:UITapGestureRecognizer){
    DispatchQueue.main.async {
    self.dayTopView.backgroundColor = .clear
    self.weekTopView.backgroundColor = .clear
    self.monthTopView.backgroundColor = .clear
    self.yearTopView.backgroundColor = .clear
    self.twoYearsTopView.backgroundColor = .black
    }
  }
  
}
