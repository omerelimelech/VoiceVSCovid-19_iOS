//
//  NotificationViewController.swift
//  Covid19VOCAAi
//
//  Created by Worg Wis on 10/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {

    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBAction func setNotification(_ sender: UIButton) {
        //create notification
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Test", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Message_Body", arguments: nil)
        content.sound = UNNotificationSound.default
        //test: deliver in 5 seconds
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "FiveSecond", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
