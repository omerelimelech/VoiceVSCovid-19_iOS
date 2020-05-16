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
        
    //notification time
    var time: Date? {
        set{ defaults.set(newValue, forKey: "notificationDate") }
        get{ defaults.value(forKey: "notificationDate") as? Date }
    }
    
    //can use Date (if set or not set) instead, but this is clearer and doesn't count on various null
    //values to work.
    var isSet:Bool? {
        set{ defaults.set(newValue, forKey: "notificationSet") }
        get{ defaults.value(forKey: "notificationSet") as? Bool }
    }
    
    
}
