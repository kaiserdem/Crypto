//
//  ItemTableViewCell.swift
//  Crypto
//
//  Created by Kaiserdem on 21.06.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit
import Charts
class ItemTableViewCell: UITableViewCell {
  
  @IBOutlet weak var iconImageViewOutlet: UIImageView!
  @IBOutlet weak var titleLableOutlet: UILabel!
  @IBOutlet weak var chartImageViewOutlet: LineChartView!
  @IBOutlet weak var priceLabelOutlet: UILabel!
  @IBOutlet weak var changeLabelOutlet: UILabel!
  
  var tableAssets: Assets! {
    didSet {
      updateUI()
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
  var tableSparkline: Datum! {
    didSet {
      print("tableSparkline")
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
    
    chartImageViewOutlet.data = data
    chartImageViewOutlet.setScaleEnabled(false)
    chartImageViewOutlet.animate(xAxisDuration: 0.0)
    chartImageViewOutlet.drawGridBackgroundEnabled = false
    chartImageViewOutlet.xAxis.drawAxisLineEnabled = false
    chartImageViewOutlet.xAxis.drawGridLinesEnabled = false
    chartImageViewOutlet.leftAxis.drawAxisLineEnabled = false
    chartImageViewOutlet.leftAxis.drawGridLinesEnabled = false
    chartImageViewOutlet.rightAxis.drawAxisLineEnabled = false
    chartImageViewOutlet.rightAxis.drawGridLinesEnabled = false
    chartImageViewOutlet.legend.enabled = false
    chartImageViewOutlet.xAxis.enabled = false
    chartImageViewOutlet.leftAxis.enabled = false
    chartImageViewOutlet.rightAxis.enabled = false
    chartImageViewOutlet.xAxis.drawLabelsEnabled = false
    
    addSubview(chartImageViewOutlet)
  }
}
