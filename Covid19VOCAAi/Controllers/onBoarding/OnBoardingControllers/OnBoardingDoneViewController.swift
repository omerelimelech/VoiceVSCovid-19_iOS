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
    
    struct strings{
        static let letUsKnow = "Let us know you better!"
        static let yourvoice = "your voice can beat the COVID-19"
        static let getStarted = "Get Started".localized()
    }
    @IBOutlet weak var continueButton: GradientButton!
    weak var delegate: OnBoardingDelegate?
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
    }
    
    @objc func continueTapped(){
        self.delegate?.continueTapped()
    }
    
    func setupLabels(){
        topLabel.text = strings.letUsKnow
        bottomLabel.text = strings.yourvoice
        continueButton.setTitle(strings.getStarted, for: .normal)
    }
}
