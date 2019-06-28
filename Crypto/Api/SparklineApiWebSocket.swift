//
//  SparklineApiWebSocket.swift
//  Crypto
//
//  Created by Kaiserdem on 23.06.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class SparklineApiWebSocket: NSObject {
  
  static let sharedInstance = SparklineApiWebSocket()
  
  func fetchWebSocketSparkline(completion: @escaping ([[Datum]]?) -> ()) {
    
    let ws = WebSocket("wss://demo.cryptto.io:8777")
    
    ws.event.open = {
      print("opened")
      ws.send("{\"event\":\"asset-sparklines\"}")
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
          // print("\n asset-sparkline_Json")
          let jsonSparkline = try JSONDecoder().decode(AssetSparklineWSModel.self, from: data!)
          completion(jsonSparkline.data)
        default: return
          //print("\n unsupported_Json")
        }
        //        switch someJsonModel?.event {
        //        case  "asset-sparkline" :
        //          print("\n asset-sparkline_Json")
        //          let jsonAssetsSparkline = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
        //          let datumArray = jsonAssetsSparkline["data"] as? [NSMutableArray]
        //          let assetSparklineWSModel = AssetSparklineWSModel()
        //          assetSparklineWSModel.datum = datumArray
        //          completion(assetSparklineWSModel)
        //        default:
        //          print("unsupported_Json")
        //        }
      } catch let error {
        print(error)
      }
      if let text = message as? String {
      //  print(text)
      }
    }
  }
}
