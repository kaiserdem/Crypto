//
//  DetailCoinVC.swift
//  Crypto
//
//  Created by Kaiserdem on 24.06.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit
import Charts

class DetailCoinVC: UIViewController {
  
  @IBOutlet weak var backBarCornerView: UIView!
  @IBOutlet weak var whiteBarView: UIView!
  @IBOutlet weak var iconImagevVew: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var symbolLabel: UILabel!
  @IBOutlet weak var rankLabel: UILabel!
  @IBOutlet weak var rankTitelDownLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var changeLabel: UILabel!
  @IBOutlet weak var chartImageView: LineChartView!
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
  
  var assets: [Assets]?
  var itemId = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchAssets()
    setupNavBarSettings()
    setupBarViewSettings()
    
    titleLabel.text = itemId
    
    // setLineChart(values: [0.42674666432423423,0.4269741442343242,0.42930927,0.42750263,0.42768186,0.42625276,0.42632109,0.42681791,0.42513552,0.42204073,0.42450601,0.42602617,0.42510613,0.45721984,0.45419202,0.45925019,0.45842745,0.45964609,0.46630393,0.45762964,0.45578137,0.46369375,0.4699259,0.46414812,0.4658122,0.47700516,0.4690174,0.48044204,0.47068715,0.47356953,0.47741759,0.4730036,0.47595446,0.48082541,0.47600384,0.47603397,0.47905846,0.47174694,0.46534131,0.46907852,0.46421935,0.46749744,0.47083961,0.47206238,0.47446015,0.4735839,0.47193777,0.47268355,0.472165171652468])
  }
  
  func fetchAssets() {
    AssetsApiWebSocket.sharedInstance.fetchAssets { [weak self] (assetsArray: [Assets]?) in
      guard let strongSelf = self else { return }
      strongSelf.assets = assetsArray!
    }
  }
  
  var tableAssets: Assets! {
    didSet {
      updateUI()
    }
  }
  func updateUI() {
    titleLabel.text = tableAssets?.title
    if let price = tableAssets?.price {
      let double = price.rounded(toPlaces: 2)
      priceLabel.text = String(describing: double)
    } else {
      priceLabel.text = "0"
    }
    if let change = tableAssets?.change {
      let double = change.rounded(toPlaces: 2)
      changeLabel.text = String(describing: double) + "%"
    } else {
      changeLabel.text = "0 %"
    }
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
    
    chartImageView.data = data
    chartImageView.setScaleEnabled(false)
    chartImageView.animate(xAxisDuration: 0.0)
    chartImageView.drawGridBackgroundEnabled = false
    chartImageView.xAxis.drawAxisLineEnabled = false
    chartImageView.xAxis.drawGridLinesEnabled = false
    chartImageView.leftAxis.drawAxisLineEnabled = false
    chartImageView.leftAxis.drawGridLinesEnabled = false
    chartImageView.rightAxis.drawAxisLineEnabled = false
    chartImageView.rightAxis.drawGridLinesEnabled = false
    chartImageView.legend.enabled = false
    chartImageView.xAxis.enabled = false
    chartImageView.leftAxis.enabled = false
    chartImageView.rightAxis.enabled = false
    chartImageView.xAxis.drawLabelsEnabled = false
    
    view.addSubview(chartImageView)
  }
}
