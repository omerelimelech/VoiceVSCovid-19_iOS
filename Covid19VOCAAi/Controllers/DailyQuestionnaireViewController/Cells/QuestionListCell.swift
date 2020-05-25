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
    func questionListCellDatePickerRequestedFor(cell: QuestionListCell)
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
        
        self.addSubview(inputFieldLabel)
        self.addSubview(inputField)
        self.addSubview(textFieldCoverView)
        self.addSubview(inputFieldBottomLine)
        
        NSLayoutConstraint.activate([
            inputFieldLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 27),
            inputFieldLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 24),
            
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
        label.text = currentQuestion.question.text
        firstOptionCheckmarkLabel.text = currentQuestion.question.answerOptions.first
        secondOptionCheckmarkLabel.text = currentQuestion.question.answerOptions.last
        inputField.text = currentQuestion.inputDataAnswer
        
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
                textFieldCoverView.isHidden = false
                
            case .number(inputFieldName: let temperaturePickerTitle):
                self.currentInputType = .number(inputFieldName: temperaturePickerTitle)
                inputFieldLabel.text = temperaturePickerTitle
                inputFieldLabel.sizeToFit()
                textFieldCoverView.isHidden = true
            }
            
        default:
            inputFieldLabel.isHidden = true
            inputFieldBottomLine.isHidden = true
            inputField.isHidden = true
        }
        layoutIfNeeded()
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
        delegate?.questionListCell(self, inputFieldTextDidChange: inputField.text ?? "")
    }
}

// MARK: Buttons

extension QuestionListCell {
    func selectYes() {
        self.firstOptionCheckmark.setImage(self.selectedButtonImage, for: .normal)
        self.secondOptionCheckmark.setImage(self.unselectedButtonImage, for: .normal)
        delegate?.questionListCell(self, didSelectAnswer: question?.question.answerOptions.first ?? "")
    }
    
    func selectNo() {
        self.firstOptionCheckmark.setImage(self.unselectedButtonImage, for: .normal)
        self.secondOptionCheckmark.setImage(self.selectedButtonImage, for: .normal)
        
        delegate?.questionListCell(self, didSelectAnswer: question?.question.answerOptions.last ?? "")
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
