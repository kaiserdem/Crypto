//
//  AssetsApiWebSocket.swift
//  Crypto
//
//  Created by Kaiserdem on 20.06.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import Foundation

class AssetsApiWebSocket: NSObject {
  
  static let sharedInstance = AssetsApiWebSocket()
  
  func fetchAssets(completion: @escaping ([Assets]?) -> ()) {
    
    let ws = WebSocket("wss://demo.cryptto.io:8777")
    
    ws.event.open = {
      print("opened")
      ws.send("{\"event\":\"assets\"}")
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
        case "assets":
          let jsonAssets = try JSONDecoder().decode(AssetsJsonModel.self, from: data!)
          completion(jsonAssets.assets)
        default:
          print("\n assets_Json")
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
