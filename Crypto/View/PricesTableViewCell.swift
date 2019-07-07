//
//  ItemTableViewCell.swift
//  Crypto
//
//  Created by Kaiserdem on 21.06.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit
import Charts

class PricesTableViewCell: UITableViewCell {
  
  @IBOutlet weak var iconImageViewOutlet: UIImageView!
  @IBOutlet weak var titleLableOutlet: UILabel!
  @IBOutlet weak var lineChartView: LineChartView!
  @IBOutlet weak var priceLabelOutlet: UILabel!
  @IBOutlet weak var changeLabelOutlet: UILabel!
  
  
  
  
  var tableAssets: Assets! {
    didSet {
      updateUI()
      
    //  setLineChart(values: [0.48674666,0.48679666,0.48671666,0.42674666,0.42697414,0.42930927,0.42750263,0.42768186,0.42625276,0.42632109,0.42681791,0.42513552,0.42204073,0.42450601,0.42602617,0.42510613,0.45721984,0.45419202,0.45925019,0.45842745,0.45964609,0.46630393,0.45762964,0.45578137,0.46369375,0.4699259,0.46414812,0.4658122,0.47700516,0.4690174,0.48044204,0.47068715,0.47356953,0.47741759,0.4730036,0.47595446,0.48082541,0.47600384,0.47603397,0.47905846,0.47174694,0.46534131,0.46907852,0.46421935,0.46749744,0.47083961,0.47206238,0.47446015,0.4735839,0.47193777,0.47268355,0.472165171652468])
    }
  }
  func updateUI() {
    titleLableOutlet.text = tableAssets?.title
    if let price = tableAssets?.price {
      let double = price.rounded(toPlaces: 2)
      priceLabelOutlet.text = String(describing: double)
    } else {
      priceLabelOutlet.text = "0"
    }
    if let change = tableAssets?.change {
      let double = change.rounded(toPlaces: 2)
      changeLabelOutlet.text = String(describing: double) + "%"
    } else {
      changeLabelOutlet.text = "0 %"
    }
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
}
