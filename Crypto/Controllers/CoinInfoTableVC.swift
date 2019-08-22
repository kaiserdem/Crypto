//
//  PriceComparisonVC.swift
//  Crypto
//
//  Created by Kaiserdem on 30.06.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class CoinInfoTableVC: UITableViewController {

  
  var modelArray = [String]()
  
    override func viewDidLoad() {
        super.viewDidLoad()

      modelArray = ["bitcoin", "litecoin", "xrp", "bitcoin cash", "ethreum", "tether", "eos", "stellar", "carnado", "monero", "dash"]
        
    }

//  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    return 54
//  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return modelArray.count
   // return assetsModel.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "priceComparisonId", for: indexPath) //as! PriceComparisonTableCell
    let tableAssets = modelArray[indexPath.row]
   // cell.tableAssets = tableAssets
    cell.textLabel?.text = modelArray[indexPath.row]
    return cell    
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  //  self.idString = assetsModel[indexPath.row].id!
  //  performSegue(withIdentifier: "detailSegueId", sender: self)
  }
  
 // override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  //  var vc = segue.destination as! DetailCoinVC
  //  vc.itemId = self.idString
  //}
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "InfoSegue" {
      let infoTabVC = segue.destination as? CoinInfoTableVC
      infoTabVC?.modelArray = ["bitcoin", "litecoin", "xrp", "bitcoin cash", "ethreum", "tether", "eos", "stellar", "carnado", "monero", "dash"]
    }
  }
}
