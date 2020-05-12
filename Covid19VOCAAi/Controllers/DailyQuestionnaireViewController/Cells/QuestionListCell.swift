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
    func questionListCell(_ cell: QuestionListCell, didSelectAnswer answer: String)
    func questionListCell(_ cell: QuestionListCell, inputFieldTextDidChange text: String)
}

class QuestionListCell: UITableViewCell {
    private let selectedButtonImage = UIImage(named: "checkmarkChecked")
    private let unselectedButtonImage = UIImage(named: "checkmarkUnchecked")
    
    static let ReuseIdentifier = StringHelper.stringForClass(QuestionListCell.self)
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var firstOptionCheckmark: UIButton!
    @IBOutlet weak var firstOptionCheckmarkLabel: UILabel!
    @IBOutlet weak var secondOptionCheckmark: UIButton!
    @IBOutlet weak var secondOptionCheckmarkLabel: UILabel!
    @IBOutlet weak var bottomSeparator: UIView!
    
    lazy var inputField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .none
        tf.textAlignment = .center
        tf.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        tf.keyboardType = .numberPad
        return tf
    }()
    
    var inputFieldLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 14)
        return lbl
    }()
    
    var inputFieldBottomLine: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .lightGray
        return v
    }()
    
    weak var delegate: QuestionListCellDelegate?
    
    var question: DailyQuestion? {
        didSet {
            didSetQuestion()
        }
    }
    
    var currentInputType: DailyQuestion.RelatedData?
    
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
        
        self.addSubview(inputFieldLabel)
        self.addSubview(inputField)
        self.addSubview(inputFieldBottomLine)
        
        NSLayoutConstraint.activate([
            inputFieldLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 27),
            inputFieldLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 24),
            
            inputField.centerYAnchor.constraint(equalTo: inputFieldLabel.centerYAnchor),
            inputField.widthAnchor.constraint(equalToConstant: 60),
            inputField.heightAnchor.constraint(equalToConstant: 20),
            inputField.leadingAnchor.constraint(equalTo: inputFieldLabel.trailingAnchor, constant: 10),
            
            inputFieldBottomLine.topAnchor.constraint(equalTo: inputField.bottomAnchor),
            inputFieldBottomLine.leadingAnchor.constraint(equalTo: inputField.leadingAnchor),
            inputFieldBottomLine.trailingAnchor.constraint(equalTo: inputField.trailingAnchor),
            inputFieldBottomLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func configure() {
        setDefaultState()
    }
    
    func didSetQuestion() {
        guard let currentQuestion = question else { return }
        label.text = currentQuestion.text
        firstOptionCheckmarkLabel.text = currentQuestion.answerOptions.first
        secondOptionCheckmarkLabel.text = currentQuestion.answerOptions.last
        
        switch currentQuestion.type {
        case .yesNoWithInput(inputType: let inputType):
            
            inputFieldLabel.isHidden = false
            inputFieldBottomLine.isHidden = false
            inputField.isHidden = false
            
            switch inputType {
            case .date(inputFieldName: let datePickerTitle):
                self.currentInputType = .date(inputFieldName: datePickerTitle)
                inputFieldLabel.text = datePickerTitle
                inputFieldLabel.sizeToFit()
            case .number(inputFieldName: let temperaturePickerTitle):
                self.currentInputType = .number(inputFieldName: temperaturePickerTitle)
                inputFieldLabel.text = temperaturePickerTitle
                inputFieldLabel.sizeToFit()
            }
            
        default:
            inputFieldLabel.isHidden = true
            inputFieldBottomLine.isHidden = true
            inputField.isHidden = true
        }
        layoutIfNeeded()
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
    
    @objc func textFieldDidChange() {
        delegate?.questionListCell(self, inputFieldTextDidChange: inputField.text ?? "")
    }
}

// MARK: Buttons

extension QuestionListCell {
    func selectYes() {
        animateTransitionOf(view: firstOptionCheckmark, animationHandler: { self.firstOptionCheckmark.setImage(self.selectedButtonImage, for: .normal) })
        animateTransitionOf(view: firstOptionCheckmark, animationHandler: { self.secondOptionCheckmark.setImage(self.unselectedButtonImage, for: .normal) })
        
        delegate?.questionListCell(self, didSelectAnswer: question?.answerOptions.first ?? "")
    }
    
    func selectNo() {
        animateTransitionOf(view: firstOptionCheckmark, animationHandler: { self.firstOptionCheckmark.setImage(self.unselectedButtonImage, for: .normal) })
        animateTransitionOf(view: firstOptionCheckmark, animationHandler: { self.secondOptionCheckmark.setImage(self.selectedButtonImage, for: .normal) })
        
        delegate?.questionListCell(self, didSelectAnswer: question?.answerOptions.last ?? "")
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
