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
    cell.tableAssets = tableAssets
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.sendAssets = [assetsModel[indexPath.row]]
    
    performSegue(withIdentifier: "detailSegueId", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    var vc = segue.destination as! CoinInfoVC
    vc.acceptAssets = self.sendAssets
  }
  
}
