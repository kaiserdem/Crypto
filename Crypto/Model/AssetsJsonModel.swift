//
//  AssetsJsonModel.swift
//  Crypto
//
//  Created by Kaiserdem on 20.06.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import Foundation

import Foundation

struct AssetsJsonModel: Decodable {
  
  let assets: [Assets]
  let event: String
  
  enum CodingKeys: String, CodingKey {
    case assets
    case event
  }
}
class Assets: Decodable {
  var id: String
  var symbol: String
  var title: String
  var icon: String
  var changed: Bool // изменено
  var price: Double // цена
  var rank: Int     // звание, разряд
  var change: Double // измения
  var circulating: Double // циркулирующий
  var maxSupply: Double // максимальная ставка
  var volume24: Double // объем за сутки
  var marketcap: Double // Рыночная капитализация
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case symbol = "symbol"
    case title = "title"
    case icon = "icon"
    case changed = "changed"
    case price = "price"
    case rank = "rank"
    case change = "change"
    case circulating = "circulating"
    case maxSupply = "maxSupply"
    case volume24 = "volume24"
    case marketcap = "marketcap"
  }
  
}
