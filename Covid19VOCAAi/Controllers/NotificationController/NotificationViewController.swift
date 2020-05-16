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
    
    @IBOutlet weak var laterButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    var presenter: NotificationPresenter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initialize presenter
        presenter = NotificationPresenter(with:self)
        //arrange question text
        label.text = "When to remind you again?".localized()
        label.sizeToFit()
        label.center.x = self.view.center.x
        //use presenter to check if have permission to set notifications
        presenter?.checkAuthorization()
        
        //***REMOVE THIS*** for full program
        //refresh every time view comes in foreground
        NotificationCenter.default.addObserver(self, selector: #selector(onResume), name:
            UIApplication.willEnterForegroundNotification, object: nil)
        
        
    }
    
    //***REMOVE THIS*** for full program
    //when application comes into foreground, check mode
    @objc func onResume() {
        presenter?.checkNotification()
        
    }
    
    @IBAction func setNotification(_ sender: UIButton) {
        //get user time
        let date = timePicker.date;
        presenter?.setNotification(date: date)
    }
    
    @IBAction func setLater(_ sender: UIButton) {
        presenter?.setLater()
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
    //reaction to authorization check
    func authorizationResult(isAllowed: Bool) {
        if (!isAllowed){
            //show message and go to next view?
            print ("no notifications for you")
            doneButton.isEnabled = false
        }
        else {
            //use presenter to see what mode we are in
            presenter?.checkNotification()
        }
    }
    
    //reaction on notification error
    func notificationFailed(error: Error) {
        //show error somehow?
        print("Uh oh... \(error.localizedDescription)")
    }
    
    //reaction on successful notification
    func notificationOK() {
        //go to next view
        print("great!")
    }
    
    //arrange view according to current mode
    func setView(haveNotification: Bool, date:Date?) {
        if (haveNotification){
            //arrange button text
            DispatchQueue.main.async {
                self.doneButton.setTitle("Done".localized(), for:.normal)
                self.laterButton.setTitle("Remove Notification".localized(), for: .normal)
                if let notificationDate = date {//set to notification time
                    self.timePicker.date = notificationDate
                }
            }
        }
        else {
            DispatchQueue.main.async {
                self.doneButton.setTitle("Done".localized(), for:.normal)
                self.laterButton.setTitle("Later".localized(), for: .normal)
                self.timePicker.date = Date()//set to current time
            }
        }
        DispatchQueue.main.async {
            self.doneButton.sizeToFit()
            self.doneButton.center.x = self.view.center.x
            self.laterButton.sizeToFit()
            self.laterButton.center.x = self.view.center.x
        }
    }
    
    
}
