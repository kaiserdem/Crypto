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
