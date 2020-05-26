//
//  DailyQuestionsViewController+Table.swift
//  Covid19VOCAAi
//
//  Created by Yevhenii on 09.05.2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

extension DailyQuestionsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count + 1 // + continue button row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath == continueButtonIndexPath {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ActionButtonCell.ReuseIdentifier, for: indexPath) as? ActionButtonCell else { return UITableViewCell() }
            cell.actionButton.setTitle("Continue", for: .normal)
            cell.delegate = self
            return cell
        }
        
        let question = questions[indexPath.row]
        
        switch question.type {
        case .yesNoType:
            //No case for this cell
            return UITableViewCell()
            
        case .checkboxed:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionCheckboxCell.ReuseIdentifier, for: indexPath) as? QuestionCheckboxCell else { return UITableViewCell() }
            cell.delegate = self
            cell.setData(question: question)
            return cell
            
        case .yesNoWithInput:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionListCell.ReuseIdentifier, for: indexPath) as? QuestionListCell else { return UITableViewCell() }
            cell.delegate = self
            cell.question = question
             return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = DailyQuestionsHeaderView().loadNib(StringHelper.stringForClass(DailyQuestionsHeaderView.self)) as? DailyQuestionsHeaderView else { return nil }
        view.imageView.image = UIImage(named: "medical_left_to_right")
        view.imageView.transform = LanguageType.current == .eng ? CGAffineTransform(scaleX: -1, y: 1) : .identity
        view.titleLabel.text = "Please, answer the questions"
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 128
    }
}

// MARK: Cell Delegate

extension DailyQuestionsViewController: QuestionListCellDelegate {
    
    func questionListCell(_ cell: QuestionListCell, didSelectAnswer answer: String) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        questions[indexPath.row].submittedAnswer = answer
    }
    
    func questionListCell(_ cell: QuestionListCell, inputFieldTextDidChange text: String) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        questions[indexPath.row].inputDataAnswer = text
    }
    
    func questionListCellDatePickerRequestedFor(cell: QuestionListCell) {
        let datePicker = DatePickerActionSheet()
        datePicker.dateStringHandler = { [weak cell] dateString in
            guard let wkCell = cell else { return }
            wkCell.inputField.text = dateString
            wkCell.submit()
        }
        
        self.present(datePicker, animated: true)
    }
}

// MARK: Checkbox cell delegate

extension DailyQuestionsViewController: QuestionCheckboxCellDelegate {
    
    func questionCheckboxCell(_ cell: QuestionCheckboxCell, didSelectVariant variant: String) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        questions[indexPath.row].submittedAnswer = variant
    }
}

// MARK: Continue button delegate

extension DailyQuestionsViewController: ActionButtonCellDelegate {
    func actionButtonDidTap(cell: ActionButtonCell, button: GradientButton) {
        sendResults()
    }
}
