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
        guard let cameraVC = UIStoryboard(name: "PersonalDetails", bundle: nil).instantiateViewController(withIdentifier: "SympthomsViewController") as? SympthomsViewController else {return}
        
        self.present(cameraVC, animated: true, completion: nil)
    }
    
    

}


class VoiceUpMainPresenter: BasePresenter{
    
}
