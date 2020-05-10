//
//  QuestionListCell.swift
//  Covid19VOCAAi
//
//  Created by Yevhenii on 09.05.2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

import UIKit

protocol QuestionListCellDelegate: class {
    func didSelectYesOption()
    func didSelectNoOption()
    func inputFieldTextDidChange(text: String)
}

class QuestionListCell: UITableViewCell {
    
    struct Config {
        var title: String
        var yesButtonText: String
        var noButtonText: String
        var textFieldDescription: String?
    }
    
    private let selectedButtonImage = UIImage(named: "checkmarkChecked")
    private let unselectedButtonImage = UIImage(named: "checkmarkUnchecked")
    
    static let ReuseIdentifier = StringHelper.stringForClass(QuestionListCell.self)
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var inputFieldLabel: UILabel!
    @IBOutlet weak var inputFieldUnderline: UIView!
    @IBOutlet weak var firstOptionCheckmark: UIButton!
    @IBOutlet weak var firstOptionCheckmarkLabel: UILabel!
    @IBOutlet weak var secondOptionCheckmark: UIButton!
    @IBOutlet weak var secondOptionCheckmarkLabel: UILabel!
    @IBOutlet weak var bottomSeparator: UIView!
    
    weak var delegate: QuestionListCellDelegate?
    
    var config: Config? {
        didSet {
            didSetConfig()
        }
    }
    
    var showsBottomSeparator: Bool {
        set {
            bottomSeparator.isHidden = !newValue
        }
        get {
            return bottomSeparator.isHidden
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func configure() {
        setDefaultState()
    }
    
    func didSetConfig() {
        guard let conf = config else { return }
        label.text = conf.title
        firstOptionCheckmarkLabel.text = conf.yesButtonText
        secondOptionCheckmarkLabel.text = conf.noButtonText
        
        if let inputFieldText = conf.textFieldDescription {
            inputFieldLabel.text = inputFieldText
            inputFieldLabel.isHidden = false
            inputFieldUnderline.isHidden = false
            inputField.isHidden = false
        } else {
            inputFieldLabel.isHidden = true
            inputFieldUnderline.isHidden = true
            inputField.isHidden = true
        }
    }
    
    private func animateTransitionOf(view: UIView, animationHandler: @escaping (() -> Void)) {
        UIView.transition(with: firstOptionCheckmark,
                          duration: 0.1,
                          options: [.beginFromCurrentState, .transitionCrossDissolve],
                          animations: {
                            animationHandler()
        },
                          completion: nil)
    }
}

// MARK: Buttons

extension QuestionListCell {
    func selectYes() {
        animateTransitionOf(view: firstOptionCheckmark, animationHandler: { self.firstOptionCheckmark.setImage(self.selectedButtonImage, for: .normal) })
        animateTransitionOf(view: firstOptionCheckmark, animationHandler: { self.secondOptionCheckmark.setImage(self.unselectedButtonImage, for: .normal) })
        delegate?.didSelectYesOption()
    }
    
    func selectNo() {
        animateTransitionOf(view: firstOptionCheckmark, animationHandler: { self.firstOptionCheckmark.setImage(self.unselectedButtonImage, for: .normal) })
        animateTransitionOf(view: firstOptionCheckmark, animationHandler: { self.secondOptionCheckmark.setImage(self.selectedButtonImage, for: .normal) })
        delegate?.didSelectNoOption()
    }
    
    func setDefaultState() {
        firstOptionCheckmark.setImage(unselectedButtonImage, for: .normal)
        secondOptionCheckmark.setImage(unselectedButtonImage, for: .normal)
    }
    
    @IBAction func didSelectFirstOption(_ sender: UIButton) {
        selectYes()
    }
    @IBAction func didSelectSecondOption(_ sender: UIButton) {
        selectNo()
    }
}
