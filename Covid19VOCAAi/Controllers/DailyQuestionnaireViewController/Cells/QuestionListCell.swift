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
    func questionListCellDidSelectPositiveAnswer(forQuestion question: DailyQuestionVM)
    func questionListCellDidSelectNegativeAnswer(forQuestion question: DailyQuestionVM)
    func questionListCell(inputFieldTextDidChange text: String, forQuestion question: DailyQuestionVM)
    func questionListCellDatePickerRequestedFor(cell: QuestionListCell)
}

class QuestionListCell: UITableViewCell {
    private let selectedButtonImage = UIImage(named: "checkmarkChecked")
    private let unselectedButtonImage = UIImage(named: "checkmarkUnchecked")
    
    static let ReuseIdentifier = StringHelper.stringForClass(QuestionListCell.self)
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var positiveOptionCheckmark: UIButton!
    @IBOutlet weak var positiveOptionCheckmarkLabel: UILabel!
    @IBOutlet weak var negativeOptionCheckmark: UIButton!
    @IBOutlet weak var negativeOptionCheckmarkLabel: UILabel!
    @IBOutlet weak var bottomSeparator: UIView!
    
    lazy var inputField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .none
        tf.textAlignment = .center
        tf.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        tf.addTarget(self, action: #selector(inputFieldEndEditing), for: .editingDidEnd)
        tf.keyboardType = .numberPad
        return tf
    }()
    
    var inputFieldLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 14)
        return lbl
    }()
    
    lazy var textFieldCoverView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        v.isUserInteractionEnabled = true
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnTextField)))
        return v
    }()
    
    var inputFieldBottomLine: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .lightGray
        return v
    }()
    
    weak var delegate: QuestionListCellDelegate?
    
    var question: DailyQuestionVM? {
        didSet {
            didSetQuestion()
        }
    }
    
    var currentInputType: DailyQuestion.RelatedData?
    
    private var pendingInputFieldText: String?
    
    var showsBottomSeparator: Bool {
        set {
            bottomSeparator.isHidden = !newValue
        }
        get {
            return bottomSeparator.isHidden
        }
    }
    
    var hidesTextFieldOnNegativeAnswer: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
        
        self.addSubview(inputFieldLabel)
        self.addSubview(inputField)
        self.addSubview(textFieldCoverView)
        self.addSubview(inputFieldBottomLine)
        
        NSLayoutConstraint.activate([
            inputFieldLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 27),
            inputFieldLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 32),
            
            inputField.centerYAnchor.constraint(equalTo: inputFieldLabel.centerYAnchor),
            inputField.widthAnchor.constraint(equalToConstant: 100),
            inputField.heightAnchor.constraint(equalToConstant: 20),
            inputField.leadingAnchor.constraint(equalTo: inputFieldLabel.trailingAnchor, constant: 10),
            
            textFieldCoverView.topAnchor.constraint(equalTo: inputField.topAnchor),
            textFieldCoverView.leadingAnchor.constraint(equalTo: inputField.leadingAnchor),
            textFieldCoverView.bottomAnchor.constraint(equalTo: inputField.bottomAnchor),
            textFieldCoverView.trailingAnchor.constraint(equalTo: inputField.trailingAnchor),
            
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
        label.text = currentQuestion.origin.text
        positiveOptionCheckmarkLabel.text = (currentQuestion.origin.answerOptions as? [AnswerOption])?.first?.localizedAnswer
        negativeOptionCheckmarkLabel.text = (currentQuestion.origin.answerOptions  as? [AnswerOption])?.last?.localizedAnswer
        inputField.text = currentQuestion.inputDataAnswer
        
        switch currentQuestion.type {
        case .yesNoWithInput(inputType: let inputType):
            
            switch inputType {
            case .date(inputFieldName: let datePickerTitle):
                self.currentInputType = .date(inputFieldName: datePickerTitle)
                inputFieldLabel.text = datePickerTitle
                inputFieldLabel.sizeToFit()
                textFieldCoverView.isHidden = false
                
            case .number(inputFieldName: let temperaturePickerTitle):
                self.currentInputType = .number(inputFieldName: temperaturePickerTitle)
                inputFieldLabel.text = temperaturePickerTitle
                inputFieldLabel.sizeToFit()
                textFieldCoverView.isHidden = true
            }
            
            if hidesTextFieldOnNegativeAnswer, let submittedAnswer = question?.submittedAnswer as? AnswerOption, submittedAnswer == .positive {
                setHidden(false, animated: true)
            } else if !hidesTextFieldOnNegativeAnswer, let _ = question?.submittedAnswer as? AnswerOption {
                setHidden(false, animated: true)
            } else {
                setHidden(true, animated: true)
            }
        
        default:
            setInputFieldHidden(true, animated: false)
        }
        
        layoutIfNeeded()
    }
    
    func setHidden(_ isHidden: Bool, animated: Bool) {
        guard let question = question else { return }
        switch question.type {
        case .yesNoWithInput:
            setInputFieldHidden(isHidden, animated: animated)
        default: break
        }
    }
    
    func setInputFieldHidden(_ isHidden: Bool, animated: Bool) {
        
        func set() {
            inputFieldLabel.isHidden = isHidden
            inputFieldBottomLine.isHidden = isHidden
            inputField.isHidden = isHidden
        }
        
        guard animated else { set(); return }
        
        if isHidden {
            UIView.animate(withDuration: 0.2,
                           delay: 0,
                           animations: {
                            self.inputFieldLabel.transform = CGAffineTransform(translationX: -300, y: 0)
                            self.inputFieldBottomLine.transform = CGAffineTransform(translationX: -300, y: 0)
                            self.inputField.transform = CGAffineTransform(translationX: -300, y: 0)
            }) { _ in
                set()
            }
        } else {
            
            set()
            
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 6,
                           options: [.beginFromCurrentState],
                           animations: {
                                self.inputFieldLabel.transform = .identity
                                self.inputFieldBottomLine.transform = .identity
                                self.inputField.transform = .identity
            }, completion: nil)
        }
    }
    
    //Called if question input based on date
    @objc func didTapOnTextField() {
        guard inputField.isEnabled else { return }
        delegate?.questionListCellDatePickerRequestedFor(cell: self)
    }
    
    @objc func inputFieldEndEditing() {
        submit()
    }
    
    @objc func textFieldDidChange() {
        pendingInputFieldText = inputField.text
    }
    
    func submit() {
        guard let question = question else { return }
        delegate?.questionListCell(inputFieldTextDidChange: inputField.text ?? "", forQuestion: question)
    }
}

// MARK: Buttons

extension QuestionListCell {
    func selectYes() {
        self.positiveOptionCheckmark.setImage(self.selectedButtonImage, for: .normal)
        self.negativeOptionCheckmark.setImage(self.unselectedButtonImage, for: .normal)
        guard let question = question else { return }
        delegate?.questionListCellDidSelectPositiveAnswer(forQuestion: question)
    }
    
    func selectNo() {
        self.positiveOptionCheckmark.setImage(self.unselectedButtonImage, for: .normal)
        self.negativeOptionCheckmark.setImage(self.selectedButtonImage, for: .normal)
        guard let question = question else { return }
        delegate?.questionListCellDidSelectNegativeAnswer(forQuestion: question)
    }
    
    func setDefaultState() {
        positiveOptionCheckmark.setImage(unselectedButtonImage, for: .normal)
        negativeOptionCheckmark.setImage(unselectedButtonImage, for: .normal)
    }
    
    @IBAction func didSelectFirstOption(_ sender: UIButton) {
        selectYes()
    }
    @IBAction func didSelectSecondOption(_ sender: UIButton) {
        selectNo()
    }
}
