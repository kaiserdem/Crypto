//
//  AssetPriceApiWebSocket.swift
//  Crypto
//
//  Created by Kaiserdem on 23.06.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class AssetPriceApiWebSocket: NSObject {

  
  static let sharedInstance = AssetPriceApiWebSocket()
  
  func fetchWebSocket(completion: @escaping (AssetPriceWSModel?) -> ()) {
    
    let ws = WebSocket("wss://demo.cryptto.io:8777")
    
    ws.event.open = {
      print("opened")
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
          //        case  "hello":
          //          print("\n hello_Json")
          //        case  "nonce":
          //          print("\n nonce_Json")
          //        case  "market-price":
          //          print("\n market-price_Json")
          //        case "rates":
          //          print("\n rates_Json")
          //        case "assets":
          //          print("\n asset_Json")
          //        case  "asset-sparkline" :
        //          print("\n asset-sparkline_Json")
        case  "asset-price":
          // print("\n asset-price_Json")
          let jsonAssetsPrice = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
          let pricesArray = jsonAssetsPrice["prices"] as? [NSMutableArray]
          var assetPriceWSModel = AssetPriceWSModel()
          assetPriceWSModel.prices = pricesArray
          completion(assetPriceWSModel)
        default: return
          //print("\n unsupported_Json")
        }
      } catch let error {
        print(error)
      }
      if let text = message as? String {
       // print(text)
      }
    }
  }
}

/*
 {"event":"hello","version":"0.5.22"}
 {"event":"exchanges","checksum":"1560263624966"}
 {"event":"assets"}
 {"event":"asset-sparklines"}
 {"event":"symbology","checksum":"1560304828943"}
 {"event":"stats"}
 {"event":"exchanges"}
 {"event":"symbology"}
 
 "{\"event\":\"assets\"}"
 //let msg = "event: assets \(NSDate().description)"
 */
