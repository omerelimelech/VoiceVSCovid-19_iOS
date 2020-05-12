//
//  NotificationViewController.swift
//  Covid19VOCAAi
//
//  Created by Danielle Honigstein on 10/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    var presenter: NotificationPresenter?
    
    @IBOutlet weak var laterButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBAction func setNotification(_ sender: UIButton) {
        //get user time
        let date = timePicker.date;
        presenter?.setNotification(date: date)
    }
    
    @IBAction func setLater(_ sender: UIButton) {
        print("pressed setlater")
        presenter?.setLater()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = NotificationPresenter(with:self)
        //arrange question text
        label.text = "When to remind you again?".localized()
        label.sizeToFit()
        label.center.x = self.view.center.x
        presenter?.checkNotification()
        NotificationCenter.default.addObserver(self, selector: #selector(onResume), name:
        UIApplication.willEnterForegroundNotification, object: nil)
        
        
    }
    
    @objc func onResume() {
        presenter?.checkNotification()

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

extension NotificationViewController:NotificationDelegate{
    func notificationFailed(error: Error) {
        //show error somehow?
        print("Uh oh... \(error.localizedDescription)")
    }
    
    func notificationOK() {
        //go to next view
        print("great!")
    }
    
    func setView(haveNotification: Bool, date:Date?) {
        if (haveNotification){
            //arrange button text
            doneButton.setTitle("Done".localized(), for:.normal)
            laterButton.setTitle("Remove Notification".localized(), for: .normal)
            if let notificationDate = date {
                timePicker.date = notificationDate
            }
        }
        else {
            doneButton.setTitle("Done".localized(), for:.normal)
            laterButton.setTitle("Later".localized(), for: .normal)
            timePicker.date = Date()
            
            
            
        }
        doneButton.sizeToFit()
        doneButton.center.x = self.view.center.x
        laterButton.sizeToFit()
        laterButton.center.x = self.view.center.x
    }
    
    
}
