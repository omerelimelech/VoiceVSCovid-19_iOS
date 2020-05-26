//
//  ExperienceSymptomsViewController.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 16/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit
import Firebase

class ExperienceSymptomsViewController: UIViewController {

    static func initialization() -> ExperienceSymptomsViewController {
        return UIStoryboard(name: "PersonalDetails", bundle: nil).instantiateViewController(withIdentifier: "ExperienceSymptomsViewController") as! ExperienceSymptomsViewController
    }
    @IBOutlet weak var yesButton: VoiceUpContinueButton!
    
    @IBOutlet weak var noButton: VoiceUpContinueButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        yesButton.setTitle("Yes".localized(), for: .normal)
        noButton.setTitle("No".localized(), for: .normal)
        [yesButton, noButton].forEach({$0.setClear()})
    }
    

    @IBAction func buttonTapped(_ sender: VoiceUpContinueButton) {
        // YES TAG - 1
        // NO TAG - 2
        let hasSymptoms = (sender.tag==1) ? true :false;
        Analytics.logEvent("has_symptoms_tapped",parameters: [
        "has_symptoms": hasSymptoms as NSObject])
        switch sender.tag {
        case 1:
            yesButton.setEnabled()
            noButton.setClear()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.navigate(.dailyQuestionnaire3)
            }
        case 2:
            yesButton.setClear()
            noButton.setEnabled()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.navigate(.voiceExplainer)
            }
        default:
            return
        }
    }
    

}
