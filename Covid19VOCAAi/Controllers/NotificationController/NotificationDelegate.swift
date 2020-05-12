//
//  NotificationDelegate.swift
//  Covid19VOCAAi
//
//  Created by Worg Wis on 12/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation

protocol NotificationDelegate : class {
    func notificationFailed(error: Error)
    func notificationOK()
    
    func setView(haveNotification:Bool,date:Date?)
}
