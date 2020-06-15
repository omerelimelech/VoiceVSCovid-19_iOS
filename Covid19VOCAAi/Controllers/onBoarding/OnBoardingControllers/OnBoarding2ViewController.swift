//
//  OnBoarding2ViewController.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 16/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

class OnBoarding2ViewController: TransformableViewController {

    struct strings {
        static let weThank = "We Thank ".localized()
        static let you = "You".localized()
        static let topExp = "By using this app you are helping strengthen our collective knowledge about respiratory disease, so we can get better at containing it, and ultimately defeat it".localized()
        static let research = "Research "
        static let withYou = "With You".localized()
        static let bottomExp = "This research is led by Dr. Tal Patalon, MD, Head of Innovation at Assuta Ashdod Hospital, in collaboration with the Weizmann Institute. The COVID Case Tracker was designed by doctors and scientists and originated as a volunteer initiative from the COVID-19 Sprint organized by Assuta Ashdod Hospital and IDF Innovation.".localized()
    }
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTopLabel()
        setupBottomLabel()
    }
    

    func setupTopLabel(){
        let att = NSMutableAttributedString()
            .normal(strings.weThank, size: 24)
            .bold(strings.you, size: 24)
            .bold("!", size: 24)
            .normal("\n", size: 12)
            .normal(strings.topExp, size: 14)
        topLabel.attributedText = att
    }
    
    func setupBottomLabel(){
        let att = NSMutableAttributedString()
            .bold(strings.research, size: 24)
            .normal(strings.withYou, size: 24)
            .normal("!", size: 24)
            .normal("\n", size: 12)
            .normal(strings.bottomExp, size: 14)
        bottomLabel.attributedText = att
    }

}
