//
//  RecordExplainerViewController.swift
//  Covid19VOCAAi
//
//  Created by Yevhenii on 15.05.2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

class RecordExplainerViewController: UIViewController {
    
    struct RecordExplainerTextModel {
        let title = "Sound and pulse testing"
        
        let headerOpeningText = "In the following screens we will record "
        let headerAttributedInsertion = "4 short sound samples "
        let headerInnerText = "and perform a "
        let headerSecondAttributedInsertion = "short pulse measurement "
        let headerEnclosingText = "from your finger with the camera"
        
        let descriptionHeaderText = "Why sound and pulse?"
        let descriptionText = "Studies show that changes in these physiologic signs can help with the infection diagnosis process!"
        let footerText = "It is better to measure in the morning but we will be happy if you come every hour."
        let actionButtonText = "Get started"
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descriptionHeaderLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var footerLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var actionButton: GradientButton!
    
    let strings = RecordExplainerTextModel()
    
    let commonParagraphStyle: NSMutableParagraphStyle = {
        let p = NSMutableParagraphStyle()
        p.lineSpacing = 4
        return p
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    private func initUI() {
        actionButton.setTitle("Get started", for: .normal)
        actionButton.addShadow(UIColor.mainBlue.cgColor,
                               shadowOffset: CGSize(width: 0, height: 10),
                               shadowOpacity: 0.3,
                               shadowRadius: 0.1)
        
        setText()
    }
    
    @IBAction func actionButtonDidTap(_ sender: UIButton) {
        //.//sender.animateTapResponse()
    }
}

// MARK: Label setting

private extension RecordExplainerViewController {
    
    func setText() {
        titleLabel.text = strings.title
        setHeaderLabel()
        descriptionHeaderLabel.text = strings.descriptionHeaderText
        descriptionLabel.attributedText = NSAttributedString(string: strings.descriptionText, attributes: [.font : UIFont.systemFont(ofSize: 18), .paragraphStyle : commonParagraphStyle])
        footerLabel.attributedText = NSAttributedString(string: strings.footerText, attributes:  [.font : UIFont.systemFont(ofSize: 14), .paragraphStyle : commonParagraphStyle])
    }
    
    func setHeaderLabel() {
        let baseHeaderAttributedText = NSMutableAttributedString(string: strings.headerOpeningText, attributes: [.font : UIFont.systemFont(ofSize: 18)])
        baseHeaderAttributedText.appendString(strings.headerAttributedInsertion,
                                              fontSize: 18,
                                              weight: .semibold,
                                              color: .mainBlue)
        baseHeaderAttributedText.appendString(strings.headerInnerText, fontSize: 18)
        baseHeaderAttributedText.appendString(strings.headerSecondAttributedInsertion, fontSize: 18, weight: .semibold, color: .mainBlue)
        baseHeaderAttributedText.appendString(strings.headerEnclosingText, fontSize: 18)
        baseHeaderAttributedText.addAttribute(.paragraphStyle, value: commonParagraphStyle, range: NSRange(location: 0, length: baseHeaderAttributedText.string.count))
        headerLabel.attributedText = baseHeaderAttributedText
    }
}


