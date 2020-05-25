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
        stack.spacing = 20
        return stack
    }()
    
    var question: DailyQuestion!
    private var variants = [String]()
    private var selectedVariant: String? = nil
    
    private var checkboxViews = [CheckboxView]()
    
    weak var delegate: QuestionCheckboxCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -30),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func setData(question: DailyQuestionVM) {
        self.question = question.question
        self.variants = question.question.answerOptions
        
        label.text = question.question.text
        
        configureStackView()
    }
    
    private func configureStackView() {
        
        var checkboxes = [CheckboxView]()
        
        for variant in variants {
            let checkboxView = CheckboxView(title: variant, delegate: self, isSelected: question.submittedAnswer == variant)
            checkboxes.append(checkboxView)
        }
        checkboxViews = checkboxes
        
        stackView.arrangedSubviews.forEach { (sub) in
            stackView.removeArrangedSubview(sub)
            sub.removeFromSuperview()
        }
        
        for view in checkboxViews {
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: 30)
            ])
            stackView.addArrangedSubview(view)
        }
        layoutIfNeeded()
    }
}

extension QuestionCheckboxCell: CheckboxViewDelegate {
    func didSelectCheckboxWithTitle(_ title: String) {
        guard title != selectedVariant else { return }
        selectedVariant = title
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
        butt.setImage(UIImage(named: "checkmarkUnchecked"), for: .normal)
        return butt
    }()
    
    lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.isUserInteractionEnabled = true
        lbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(checkboxDidTap)))
        return lbl
    }()
    
    var title: String {
        didSet {
            label.text = title
        }
    }
    
    private weak var delegate: CheckboxViewDelegate?
    var checkboxIsSelected: Bool
    
    init(title: String, delegate: CheckboxViewDelegate, isSelected: Bool) {
        self.delegate = delegate
        self.title = title
        self.checkboxIsSelected = isSelected
        super.init(frame: .zero)
        initUI()
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
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            checkbox.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            checkbox.heightAnchor.constraint(equalToConstant: 20),
            checkbox.widthAnchor.constraint(equalToConstant: 20),
            checkbox.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        self.checkbox.setImage(self.checkboxIsSelected ? UIImage(named: "checkmarkChecked") : UIImage(named: "checkmarkUnchecked"), for: .normal)
    }
    
    @objc func checkboxDidTap() {
        delegate?.didSelectCheckboxWithTitle(title)
    }
}
