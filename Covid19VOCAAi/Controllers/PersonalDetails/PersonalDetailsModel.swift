//
//  PersonalDetailsModel.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 12/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation


class PersonalDetailsModel {
    
    
    
    func registerUser(withPhoneNumber phoneHash: String, completion: @escaping completion){
        APIManager.shared.signUp(phoneNumber: phoneHash, completion: completion)
    }
    
    func sendUserInfo(params: [String: Any], completion: @escaping completion){
        APIManager.shared.postUserInfo(params: params, completion: completion)
    }
    
    
    
    
}
