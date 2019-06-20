//
//  ExchangesJsomModel.swift
//  Crypto
//
//  Created by Kaiserdem on 20.06.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import Foundation

struct ExchangesJsomModel: Decodable {
  
  let exchanges: [Exchanges]
  let event: String
  
  enum CodingKeys: String, CodingKey {
    case exchanges
    case event
  }
}

struct Exchanges: Decodable {
  let id: String?
  let title: String?
  let mb: Bool?
  let trade: Bool?
  let balance: Bool?
  let keys: Keys?
  let UID: String?
  let `default`: String?
  let apiLink: String?
  let website: String?
  
  enum CodingKeys: String, CodingKey {
    case id
    case title
    case mb
    case trade
    case balance
    case keys
    case UID
    case `default`
    case apiLink
    case website
  }
}
struct Keys: Decodable {
  let Passphrase: String?
  let Key: String?
  let Secret: String?
  
  enum CodingKeys: String, CodingKey {
    case Passphrase
    case Key
    case Secret
  }
}
