//
//  NotificationDelegate.swift
//  Covid19VOCAAi
//
//  Created by Danielle Honigstein on 12/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation

protocol NotificationDelegate : class {
    func notificationFailed(error: Error)//what to do if setting notification failed
    func notificationOK()//what to do if setting notification succeeded
    
    func setView(haveNotification:Bool,date:Date?)//set view differently if notification exists/doesn't exist
    
    func authorizationResult(isAllowed: Bool) //what to do if notifications allowed/denied
    
}
