//
//  NewMainViewController.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 10/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

class NewMainViewController: UIViewController {
    
    @IBOutlet weak var mainTextView: UITextView!
    @IBOutlet weak var learnMoreButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        mainTextView.text = "Together with researches from all around the world, we are developing a COVID19 diagnostic tool that is based on your voice samples only from both healthy individuals and those tested positive for Coronavirus. Make your mark and become a part of this historic journey by helping us diagnose and slow the spreading of Coronavirus and bring remote testing to every human in the world at NO EXPENSE!.".localized()
    }
    @IBAction func recordTapped(_ sender: UIButton) {
        guard let navigation = FormNavigationController.initialization() as? UINavigationController else {return}
        self.present(navigation, animated: true, completion: nil)
    }
    
    @IBAction func learnMoreTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "learnMore", sender: self)
    }
    


}
