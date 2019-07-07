//
//  SparklineItemApiWebSocket.swift
//  Crypto
//
//  Created by Kaiserdem on 06.07.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import Foundation
import UIKit

class SparklineItemApiWebSocket: NSObject {
  
  var acceptAssets: [Assets] = []

  static let sharedInstance = SparklineItemApiWebSocket()
  
  func fetchWebSocketAllSparkline(id: String, completion: @escaping (ItemSparklineModel?) -> ()) {
    
    let ws = WebSocket("wss://demo.cryptto.io:8777")
    
    ws.event.open = {
      print("opened")
      
      //  "{\"event\":\"asset-sparkline\", \"asset\":\"bitcoin\"}" -> "asset":bitcoin-cash}
      //  "{\"event\":\"asset-sparkline\", \"asset\":\"(id)\"}" -> "asset":"(id)"}
      
      ws.send("{\"event\":\"asset-sparkline\", \"asset\":\"\(id)\"}")
      print("{\"event\":\"asset-sparkline\", \"asset\":\"\(id)\"}")
    }
    ws.event.close = { code, reason, clean in
      print("close")
      ws.open()
    }
    ws.event.error = { error in
      print("error \(error)")
      ws.open()
    }
    ws.event.message = { message in
      do {
        guard let messageString = message as? String else { return }
        let data = messageString.data(using: .utf8)
        
        let someJsonModel = try? JSONDecoder().decode(ParsAllJsonModel.self, from: data!)
        
        switch someJsonModel?.event {
        case "asset-sparkline":
          let jsonAssetsPrice = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
          let pricesArray = jsonAssetsPrice["data"] as? [NSMutableArray]
          var itemSparklineWSModel = ItemSparklineModel()
          itemSparklineWSModel.data = pricesArray
          completion(itemSparklineWSModel)
        default: return
        }
      } catch let error {
        print(error)
      }
      if let text = message as? String {
        //print(text)
      }
    }
  }
}

