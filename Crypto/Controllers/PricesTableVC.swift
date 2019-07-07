//
//  InfoTableViewController.swift
//  Crypto
//
//  Created by Kaiserdem on 18.06.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class PricesTableVC: UITableViewController {
  
  var assetsModel: [Assets] = []
  var assetsWatchlist: [Assets] = []
  var sendAssets: [Assets] = []
  var dataItem: AssetSparklineWSModel?
  var dataArrayEmpty: [NSMutableArray] = []
  
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
    fetchSparklineData()
  }
  
  func fetchSparklineData() {
    SparklineApiWebSocket.sharedInstance.fetchWebSocketSparkline { [weak self] (dataSparklineArray: AssetSparklineWSModel?) in
      guard let  strongSelf = self else  { return }
      strongSelf.dataItem = dataSparklineArray
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 54
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return assetsModel.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! PricesTableViewCell
    let tableAssets = assetsModel[indexPath.row]
    let id  = tableAssets.id
    let change = tableAssets.change
    var greenColor = true
    if Int(change!) < 0 {
      greenColor = false
    }
    if (dataItem?.data) != nil {
      for i in (dataItem?.data)! {  // цикл графиков
        if (i[0] as! String) == id {
          cell.setLineChart(valueColor: greenColor, values: i[2] as! [Double])
        }
      }
    }
    for (key, value) in imageDictionary { // цикл картинок
      if key == id {
        cell.iconImageViewOutlet.image = value
      }
    }
    cell.tableAssets = tableAssets
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.sendAssets = [assetsModel[indexPath.row]]
    performSegue(withIdentifier: "detailSegueId", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let coinVC = segue.destination as! CoinInfoVC
    coinVC.acceptAssets = self.sendAssets
  }
}
