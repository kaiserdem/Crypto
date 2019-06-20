//
//  InfoTableViewController.swift
//  Crypto
//
//  Created by Kaiserdem on 18.06.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class InfoTableViewController: UITableViewController {

  @IBOutlet var tableViewOutlet: UITableView!
  
  var modelArray = [String]()
  var assets: [Assets] = []

    override func viewDidLoad() {
        super.viewDidLoad()
      fetchAssets()
    }
  func fetchAssets() {
    AssetsApiWebSocket.sharedInstance.fetchAssets { [weak self] (assetsArray: [Assets]?) in
      guard let strongSelf = self else { return }
      strongSelf.assets = assetsArray!
    }
  }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return assets.count
    }
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
    cell.textLabel?.text = assets[indexPath.row].title
    return cell
  }
    
}
