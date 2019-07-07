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
  var data: [Datum] = []
  
  var imageDictionary = ["bitcoin": UIImage(named: "bitcoin"),
                         "eos": UIImage(named: "eos"),
                         "cosmos": UIImage(named: "cosmos"),
                         "ethereum": UIImage(named: "ethereum"),
                         "binance-coin": UIImage(named: "binance-coin"),
                         "ripple": UIImage(named: "ripple"),
                         "dash": UIImage(named: "dash"),
                         "bitcoin-sv": UIImage(named: "bitcoin-sv"),
                         "tether": UIImage(named: "tether"),
                         "tron": UIImage(named: "tron"),
                         "cardano": UIImage(named: "cardano"),
                         "bitcoin-cash": UIImage(named: "bitcoin-cash"),
                         "monero": UIImage(named: "monero"),
                         "neo": UIImage(named: "neo"),
                         "iota": UIImage(named: "iota"),
                         "litecoin": UIImage(named: "litecoin"),
                         "ethereum-classic": UIImage(named: "ethereum-classic")]

  override func viewDidLoad() {
    super.viewDidLoad()
    
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
    for (key, value) in imageDictionary {
      if key == id {
        cell.iconImageViewOutlet.image = value
       // print(" \(key) -> \(String(describing: tableAssets.id))")
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
