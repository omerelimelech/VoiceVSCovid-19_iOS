//
//  VoiceUpMainViewController.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 02/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit
import SVProgressHUD

class VoiceUpMainViewController: UIViewController {

    static func initialization() -> VoiceUpMainViewController{
        return UIStoryboard(name: "PersonalDetails", bundle: nil).instantiateViewController(withIdentifier: "VoiceUpMainViewController") as! VoiceUpMainViewController
    }
    let presenter = VoiceUpMainPresenter()
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        APIManager.shared.login(params: ["phoneNumberHash": "0528880170"]) { (reuslt) in
            self.presenter.handleResult(result: reuslt, type: UserModel.self) { (user) in
                SVProgressHUD.dismiss()
                UserModel.shared = user ?? UserModel()
            }
        }
        
        
    }
    

    @IBAction func startTestTapped(_ sender: UIButton) {
        navigate(.dailyQuestionnaire2)
    }
    
    

}


class VoiceUpMainPresenter: BasePresenter{
    
}
