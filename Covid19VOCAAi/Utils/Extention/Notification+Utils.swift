//
//  Notification+Name.swift
//  
//
//  Created by Omer Elimelech on 3/21/18.
//  Copyright © 2018 Omer Elimelech. All rights reserved.
//

import Foundation

extension Notification.Name {
    
    static let updateRootController = Notification.Name(rawValue: "UpdateRootController")
    static let childIdChanged = Notification.Name(rawValue: "ChildIdChanged")
    static let updateAvatar = Notification.Name(rawValue: "UpdateAvatar")
    
}
