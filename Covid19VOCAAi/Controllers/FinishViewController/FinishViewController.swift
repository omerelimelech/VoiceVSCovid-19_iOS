//
//  FinishViewController.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 16/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit
import Firebase

class FinishViewController: UIViewController {

    static func initialization() -> FinishViewController{
        return UIStoryboard(name: "PersonalDetails", bundle: nil).instantiateViewController(withIdentifier: "FinishViewController") as! FinishViewController
    }
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var thanksLabel: UILabel!
    
    @IBOutlet weak var checkedInLabel: UILabel!
    
    @IBOutlet weak var shareAndHelpLabel: UILabel!
    
    @IBOutlet weak var shareButton: VoiceUpContinueButton!
    

    @IBOutlet weak var continueButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shareButton.setTitle("Share now".localized(), for: .normal)
        continueButton.setTitle("Continue".localized(), for: .normal)
        
        let att = NSMutableAttributedString()
        .bold("520 ", size: 18)
        .normal("checked in today".localized(), size: 18)
        .normal("!", size: 18)
        
        checkedInLabel.attributedText = att
        let start = GlobalData.shared.startedFlow
        let now = NSDate().timeIntervalSince1970
        let diff = now-(start ?? 0)
        
        Analytics.logEvent("finish_flow_view",parameters:["flow_time":diff as NSObject])
        

    }
    

    
    @IBAction func shareTapped(_ sender: VoiceUpContinueButton) {
        // share logic
    }
    
    @IBAction func continueTapped(_ sender: UIButton) {
        navigate(.notificationScreen)
    }
    
}
