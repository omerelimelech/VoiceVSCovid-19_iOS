//
//  NotificationModel.swift
//  Covid19VOCAAi
//
//  Created by Danielle Honigstein on 12/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//


import Foundation

class NotificationModel : NSObject {
    private var defaults = UserDefaults.standard
    
    static var shared = NotificationModel()//assuming that notificaiton update works with the same model
    
    //notification time
    var time: Date? {
        set{ defaults.set(newValue, forKey: "notificationDate") }
        get{ defaults.value(forKey: "notificationDate") as? Date }
    }
    
    
}
