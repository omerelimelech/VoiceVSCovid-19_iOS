//
//  NotificationPresenter.swift
//  Covid19VOCAAi
//
//  Created by Danielle Honigstein on 12/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//


import Foundation
import UserNotifications


public class NotificationPresenter{
    
    
   weak var delegate: NotificationDelegate?
    
    let model = NotificationModel()
    
    init(with delegate: NotificationDelegate){
        self.delegate = delegate
    }
    
    func checkNotification(){
        if let isSet = model.isSet  {
            
            delegate?.setView(haveNotification: isSet,date: model.time)
        }
        else{
            delegate?.setView(haveNotification: false,date: nil)
        }
    }
    
    func setLater(){
        //if exists and true, cancel and set to false
        //print("isset: \(model.isSet)")
        if let isSet = model.isSet  {
            if (isSet){
                //cancel notification
                let center = UNUserNotificationCenter.current()
                center.removeAllPendingNotificationRequests()
                model.isSet = false;
                //print("set isset to \(model.isSet)")
            }
        }
        //otherwise do nothing
        
    }
    
    func setNotification(date:Date){
        //update model
        model.time = date
        model.isSet = true;
        //create daily trigger
        let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second,], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        //create notification
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Test", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Message_Body", arguments: nil)
        content.sound = UNNotificationSound.default
        //schedule notification
        let request = UNNotificationRequest(identifier: "Reminder", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            if let error = error {
                self.delegate?.notificationFailed(error: error)
            }
            else {
                self.delegate?.notificationOK()
            }
        }
       
    }
    
    

}

