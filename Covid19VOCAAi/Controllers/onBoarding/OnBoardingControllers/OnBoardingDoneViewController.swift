//
//  OnBoardingDoneViewController.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 11/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation
import UIKit



protocol OnBoardingDelegate : class{
    func continueTapped()
}
class OnBoardingDoneViewController: TransformableViewController {
    
    @IBOutlet weak var continueButton: GradientButton!
    weak var delegate: OnBoardingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
    }
    
    @objc func continueTapped(){
        self.delegate?.continueTapped()
    }
    
}
