//
//  ParsAllJsonModel.swift
//  Crypto
//
//  Created by Kaiserdem on 20.06.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import Foundation

struct ParsAllJsonModel: Decodable {
  
  let event: String
  
  enum CodingKeys: String, CodingKey {
    case event
  }
}
