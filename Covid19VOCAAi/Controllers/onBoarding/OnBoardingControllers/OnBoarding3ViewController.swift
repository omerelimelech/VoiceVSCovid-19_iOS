//
//  OnBoarding3ViewController.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 16/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

class OnBoarding3ViewController: TransformableViewController {

    struct strings {
        static let yourData = "Your Data ".localized()
        static let isWord = "is ".localized()
        static let safe = "Safe".localized()
        static let topExp = "All data collected is anonymized. We take data security very seriously and will handle your data with utmost respect. Your data is protected by us act from 2020. It will only be used for health research and will not be used for commercial purposes. You can read more about how your data will be used, your rights and the steps we take to ensure it’s protected in our Privacy Policy and Frequently Asked Questions.".localized()
        static let weStartBy = "We start by ".localized()
        static let knowingYouBetter = "knowing you better".localized()
        static let jumpStraightToYour = "Jump straight to your "
        static let dailyCheck = "daily check"
        static let wellDoTheRest = "We'll do the rest"
    }
    
    
    
    @IBOutlet weak var topLabel: UILabel!
    
    
    @IBOutlet weak var step1Label: UILabel!
    
    @IBOutlet weak var step2Label: UILabel!
    
    @IBOutlet weak var step3Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTopLabel()
        setupSteps()
        
    }
    
    func setupTopLabel(){
        let att = NSMutableAttributedString()
            .bold(strings.yourData, size: 24)
            .normal(strings.isWord, size: 24)
            .bold(strings.safe, size: 24)
            .normal("\n", size: 12)
            .normal(strings.topExp, size: 14)
        
        topLabel.attributedText = att
    }
    
    func setupSteps(){
        let step1Att = NSMutableAttributedString()
            .normal(strings.weStartBy, size: 14)
            .bold(strings.knowingYouBetter, size: 14)
        step1Label.attributedText = step1Att
        
        let step2Att = NSMutableAttributedString()
            .normal(strings.jumpStraightToYour, size: 14)
            .bold(strings.dailyCheck, size: 14)
        step2Label.attributedText = step2Att
        
        let step3Att = NSMutableAttributedString()
            .bold(strings.wellDoTheRest, size: 14)
        step3Label.attributedText = step3Att
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
