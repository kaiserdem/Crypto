//
//  AssetSparklineWSModel.swift
//  Crypto
//
//  Created by Kaiserdem on 20.06.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import Foundation

struct AssetSparklineWSModel: Codable {
  let event: String
  let data: [[Datum]]
}
enum Datum: Codable {
  case doubleArray([Double])
  case string(String)
  
  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if let x = try? container.decode([Double].self) {
      self = .doubleArray(x)
      return
    }
    if let x = try? container.decode(String.self) {
      self = .string(x)
      return
    }
    throw DecodingError.typeMismatch(Datum.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Datum"))
  }
  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    switch self {
    case .doubleArray(let x):
      try container.encode(x)
    case .string(let x):
      try container.encode(x)
    }
  }
}

//class AssetSparklineWSModel {
//  var datum: [NSMutableArray]?
//}

//  public var assetSparklineWSModel: AssetSparklineWSModel {
//    willSet {
//      if let newValue = newValue {
//        print("newValue")
//      }
//    }
//    didSet {
//      if let assetSparklineWSModel = self.assetSparklineWSModel {
//        print("Now I'm \(assetSparklineWSModel)")
//      }
//    }
//  }

/*
 struct AssetSparklineWSModel : Codable {
 
 let data : [[AnyObject]]?
 let event : String?
 
 enum CodingKeys: String, CodingKey {
 case data = "data"
 case event = "event"
 }
 
 init(from decoder: Decoder) throws {
 let values = try decoder.container(keyedBy: CodingKeys.self)
 data = try values.decodeIfPresent([[AnyObject]].self, forKey: .data)
 event = try values.decodeIfPresent(String.self, forKey: .event)
 }
 
 }
 */
/*
 class AssetSparklineWSModel : NSObject, NSCoding{
 
 var data : [[AnyObject]]!
 var event : String!
 
 
 /**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */
 init(fromDictionary dictionary: [String:Any]){
 event = dictionary["event"] as? String
 }
 
 /**
 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
 */
 func toDictionary() -> [String:Any]
 {
 var dictionary = [String:Any]()
 if event != nil{
 dictionary["event"] = event
 }
 return dictionary
 }
 
 /**
 * NSCoding required initializer.
 * Fills the data from the passed decoder
 */
 @objc required init(coder aDecoder: NSCoder)
 {
 data = aDecoder.decodeObject(forKey: "data") as? [[AnyObject]]
 event = aDecoder.decodeObject(forKey: "event") as? String
 }
 
 /**
 * NSCoding required method.
 * Encodes mode properties into the decoder
 */
 @objc func encode(with aCoder: NSCoder)
 {
 if data != nil{
 aCoder.encode(data, forKey: "data")
 }
 if event != nil{
 aCoder.encode(event, forKey: "event")
 }
 }
 }
 */
