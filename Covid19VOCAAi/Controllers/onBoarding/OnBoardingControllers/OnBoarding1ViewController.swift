//
//  OnBoarding1ViewController.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 16/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

class OnBoarding1ViewController: TransformableViewController {

    struct strings {
        static let your = "Your ".localized()
        static let voice = "voice ".localized()
        static let can = "can ".localized()
        static let beat = "beat ".localized()
        static let theCovid19 = "the COVID-19 ".localized()
        static let yourVoiceCanBeatCovid19 = "Your voice can beat the COVID-19".localized()
        static let now = "Now".localized()
    }
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var nowLabel: UILabel!
    @IBOutlet weak var bubbleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        topLabelText()
        bubbleText()
        nowLabel.text = strings.now
    }
    
    func topLabelText(){
        let att = NSMutableAttributedString(string: strings.your, attributes: [.font : UIFont.openSansRegular(size: 32)])
        .bold(strings.voice, size: 32, color: .lightBlue)
            .normal(strings.can, size: 32)
            .bold(strings.beat, size: 32, color: .purpleBlue).normal(strings.theCovid19, size: 32)
        topLabel.attributedText = att
    }
    
    func bubbleText(){
        let att = NSMutableAttributedString().normal(strings.yourVoiceCanBeatCovid19, size: 14 )
        bubbleLabel.attributedText = att
    }

}
