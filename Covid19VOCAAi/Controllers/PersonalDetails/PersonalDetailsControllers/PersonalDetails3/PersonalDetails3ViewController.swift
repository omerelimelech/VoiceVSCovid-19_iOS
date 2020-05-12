//
//  PersonalDetails3ViewController.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 11/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

class PersonalDetails3ViewController: UIViewController {

    @IBOutlet weak var continueButton: VoiceUpContinueButton!
    
    @IBOutlet weak var notSmokingButton: RadioButton!
    
    @IBOutlet weak var smokingButton: RadioButton!
    
    @IBOutlet weak var stoppedSmokingButton: RadioButton!
    
    weak var delegate: PersonalDetailsDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func continueTapped(_ sender: GradientButton) {
        self.delegate?.personalDetailsViewController(self, didTapContiueWith: [PersonalDetailsKey.smokingStatus.rawValue: self.notSmokingButton.isSelected ? SmokingStatus.never : (self.smokingButton.isSelected ? SmokingStatus.current : SmokingStatus.stopped)])
    }
    @IBAction func selectionTapped(_ sender: RadioButton) {
        /* tags
            not smoking: 1
            smoking : 2
            stopped smoking: 3
         */
        
        switch sender.tag {
        case 1:
            notSmokingButton.isSelected = true
            smokingButton.isSelected = false
            stoppedSmokingButton.isSelected = false
        case 2:
            notSmokingButton.isSelected = false
            smokingButton.isSelected = true
            stoppedSmokingButton.isSelected = false
        case 3:
            notSmokingButton.isSelected = false
            smokingButton.isSelected = false
            stoppedSmokingButton.isSelected = true
        default:
            return
        }
        [notSmokingButton, smokingButton, stoppedSmokingButton].forEach({$0.select()})
        continueButton.setEnabled()
    }
    
    

}
