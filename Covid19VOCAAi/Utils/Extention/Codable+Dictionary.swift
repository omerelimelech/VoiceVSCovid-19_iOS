//
//  Codable+Dictionary.swift
//  Covid19VOCAAi
//
//  Created by Yevhenii on 27.05.2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation

extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
}
