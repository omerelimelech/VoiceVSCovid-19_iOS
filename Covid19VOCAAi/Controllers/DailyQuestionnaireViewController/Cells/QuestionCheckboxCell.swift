//
//  QuestionCheckboxCell.swift
//  Covid19VOCAAi
//
//  Created by Yevhenii on 12.05.2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

protocol QuestionCheckboxCellDelegate: class {
    func questionCheckboxCell(_ cell: QuestionCheckboxCell, didSelectVariant variant: String)
}

class QuestionCheckboxCell: UITableViewCell {

    static let ReuseIdentifier = StringHelper.stringForClass(QuestionCheckboxCell.self)
    
    @IBOutlet weak var label: UILabel!
    
    var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    var question: DailyQuestion!
    private var variants = [String]()
    
    weak var delegate: QuestionCheckboxCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            //stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
        ])
    }
    
    func setData(question: DailyQuestion) {
        self.question = question
        self.variants = question.answerOptions
        
        label.text = question.text
        
        configureStackView()
    }
    
    private func configureStackView() {
        for variant in variants {
            let checkboxView = CheckboxView(title: variant, delegate: self)
            checkboxView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                checkboxView.heightAnchor.constraint(equalToConstant: 30)
            ])
            stackView.addArrangedSubview(checkboxView)
        }
        
        stackView.sizeToFit()
        stackView.layoutIfNeeded()
    }
}

extension QuestionCheckboxCell: CheckboxViewDelegate {
    func didSelectCheckboxWithTitle(_ title: String) {
        delegate?.questionCheckboxCell(self, didSelectVariant: title)
    }
}

// MARK: - Checkbox View

protocol CheckboxViewDelegate: class {
    func didSelectCheckboxWithTitle(_ title: String)
}

class CheckboxView: UIView {
    private lazy var checkbox: UIButton = {
        let butt = UIButton()
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.addTarget(self, action: #selector(checkboxDidTap), for: .touchUpInside)
        return butt
    }()
    
    var label: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    var title: String {
        didSet {
            label.text = title
        }
    }
    
    private weak var delegate: CheckboxViewDelegate?
    
    init(title: String, delegate: CheckboxViewDelegate) {
        self.delegate = delegate
        self.title = title
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        self.addSubview(label)
        self.addSubview(checkbox)
        
        label.text = title
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.leadingAnchor.constraint(equalTo: checkbox.trailingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -27),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            checkbox.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 27),
            checkbox.heightAnchor.constraint(equalToConstant: 20),
            checkbox.widthAnchor.constraint(equalToConstant: 20),
            checkbox.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        checkboxIsSelected = false
    }
    
    var checkboxIsSelected = false {
        didSet {
            checkbox.setImage(checkboxIsSelected ? UIImage(named: "checkmarkUnchecked") : UIImage(named: "checkmarkUnchecked"), for: .normal)
        }
    }
    
    @objc func checkboxDidTap() {
        checkboxIsSelected = !checkboxIsSelected
        delegate?.didSelectCheckboxWithTitle(title)
    }
}
