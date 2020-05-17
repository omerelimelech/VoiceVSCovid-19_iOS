//
//  NotificationViewController.swift
//  Covid19VOCAAi
//
//  Created by Danielle Honigstein on 10/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {
    
    static func initialization() -> NotificationViewController{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
    }
    
    
    struct strings {
        static let weWouldLoveToSee = "We Would love to see you tomorrow!".localized()
        static let reminderOnUs = "Reminder on us".localized()
        static let reminderText = "When do you want to do your next test?".localized()
        static let setReminder = "Set Reminder".localized()
        static let later = "I'll do it later".localized()
    }
    @IBOutlet weak var reminderLabel: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var laterButton: UIButton!
    @IBOutlet weak var doneButton: VoiceUpContinueButton!
    
    var presenter: NotificationPresenter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initialize presenter
        presenter = NotificationPresenter(with:self)
        //arrange question text
        reminderLabel.text = strings.reminderText
        //use presenter to check if have permission to set notifications
        doneButton.setEnabled()
        presenter?.checkAuthorization()
        
        
        let att = NSMutableAttributedString()
            .bold(strings.weWouldLoveToSee, size: 24)
            .normal("\n", size: 12)
            .bold(strings.reminderOnUs, size: 24, color: .mainBlue)
        topLabel.attributedText = att
        
        laterButton.setTitle(strings.later, for: .normal)
        doneButton.setTitle(strings.setReminder, for: .normal)
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
        let alert = UIAlertController(title: "Thank you!", message: "Reminder is set successfully", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
            alert.dismiss(animated: true) {
                self.navigationController?.dismiss(animated: true, completion: nil)
            }
        }
        alert.addAction(action)
        DispatchQueue.main.async {
             self.present(alert, animated: true, completion: nil)
        }
    }
    
    //arrange view according to current mode
    func setView(haveNotification: Bool, date:Date?) {
        if (haveNotification){
            //arrange button text
            DispatchQueue.main.async {
                self.doneButton.setTitle(strings.setReminder, for:.normal)
                self.laterButton.setTitle("Remove Notification".localized(), for: .normal)
                if let notificationDate = date {//set to notification time
                    self.timePicker.date = notificationDate
                }
            }
        }
        else {
            DispatchQueue.main.async {
                self.doneButton.setTitle(strings.setReminder, for:.normal)
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
