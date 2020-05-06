//
//  OxymeterPreperViewController.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 02/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit
import SVProgressHUD

struct Measurment: Codable {
    let id: Int
    let filledOn, tag, tempMeasurement, exposureDate: String
    let positiveTestDate, negativeTestDate, generalFeeling: String
}

class OxymeterPreperViewController: UIViewController {

    let presenter = PreperPresenter()
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func continueTapped(_ sender: GradientButton) {
        SVProgressHUD.show()
        APIManager.shared.sendMeasurment(method: .post, params: ["tag": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        "tempMeasurement": "36",
        "exposureDate": "2020-05-02",
        "positiveTestDate": "2020-05-02",
        "negativeTestDate": "2020-05-02",
        "generalFeeling": "SAME"]) { (result) in
            self.presenter.handleResult(result: result, type: Measurment.self) { (m) in
                SVProgressHUD.dismiss()
                guard let cameraVC = UIStoryboard(name: "PersonalDetails", bundle: nil).instantiateViewController(withIdentifier: "cameraViewController") as? ViewController else {return}
                    cameraVC.measurmentId = m?.id
                self.navigationController?.pushViewController(cameraVC, animated: true)
            }
        }
    }
    

}


class PreperPresenter: BasePresenter{
    
}
