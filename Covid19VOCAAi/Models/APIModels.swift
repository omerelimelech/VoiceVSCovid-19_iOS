//
//  APIModels.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 27/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation



struct User: Codable {
    
    var id: Int?
    var lastLogin: String?
    var firstName: String?
    var lastName : String?
    var isActive: Bool?
    var email: String?
    var age: Int?
    
    enum CodingKeys: CodingKey {
        case id, lastLogin, firstName, lastName, isActive, email, age
    }
}

struct Token: Codable{
    var access: String?
    var refresh: String?
}
class UserModel : Codable{
  
    static let shared = UserModel()
    
    var user: UserModel?
    var token: Token?
    
}
