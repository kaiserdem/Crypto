//
//  ApiForResource.swift
//  Crypto
//
//  Created by Kaiserdem on 20.06.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//
import Foundation

class ApiForResource: NSObject {
  
  static let sharedInstance = ApiForResource()
  
  func fetchAssetsResource(completion: @escaping ([Assets]) -> ()) {
    
    guard let path = Bundle.main.path(forResource: "assets", ofType: "json") else { return }
    let url = URL(fileURLWithPath: path)
    
    let jsonData = try! Data(contentsOf: url)
    
    do {
      let jsonModel = try JSONDecoder().decode(AssetsJsonModel.self, from: jsonData)
      completion(jsonModel.assets)
    } catch let error {
      print(error)
    }
  }
}
