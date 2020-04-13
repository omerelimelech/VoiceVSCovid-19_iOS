//
//  FormNavigationController.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 10/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

class FormNavigationController: UINavigationController {

    
    static func initialization() -> UINavigationController? {
        var navigationController: UINavigationController?
        if GlobalData.shared.agreedToTerms ?? false{
            guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FormViewController") as? FormViewController else {return nil}
            navigationController = UINavigationController(rootViewController: vc)
        }else{
            guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TermsViewController") as? TermsViewController else {return nil}
            navigationController = UINavigationController(rootViewController: vc)
        }
        navigationController?.modalPresentationStyle = .fullScreen
        return navigationController
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
