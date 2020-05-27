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
        return rows.count + 1 // + continue button row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath == continueButtonIndexPath {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ActionButtonCell.ReuseIdentifier, for: indexPath) as? ActionButtonCell else { return UITableViewCell() }
            cell.actionButton.setTitle("Continue", for: .normal)
            cell.delegate = self
            isValid() ? cell.setEnabled() : cell.setDisabled()
            return cell
        }
        
        let question = rows[indexPath.row].question
        
        switch question.type {
        case .checkboxed:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionCheckboxCell.ReuseIdentifier, for: indexPath) as? QuestionCheckboxCell else { return UITableViewCell() }
            cell.delegate = self
            cell.setData(question: question)
            return cell
            
        case .yesNoType, .yesNoWithInput:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionListCell.ReuseIdentifier, for: indexPath) as? QuestionListCell else { return UITableViewCell() }
            cell.delegate = self
            cell.question = question
            
            switch question.origin.questionTitle {
            case .isResultPositive:
                cell.hidesTextFieldOnNegativeAnswer = false
            default:
                cell.hidesTextFieldOnNegativeAnswer = true
            }
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
        view.titleLabel.text = "Please, andswer the questions"
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 128
    }
}

// MARK: Cell Delegate

extension DailyQuestionsViewController: QuestionListCellDelegate {
    func questionListCellDidSelectPositiveAnswer(forQuestion question: DailyQuestionVM) {
        
        if let parent = questions.first(where: { $0.nestedQuestion == question.origin }), let index = questions.firstIndex(of: parent) {
            questions[index].nestedQuestion?.submittedAnswer = AnswerOption.positive
        } else {
            guard let index = questions.firstIndex(of: question) else { return }
            questions[index].submittedAnswer = AnswerOption.positive
            checkForNestedQuestions(question: questions[index], shouldExpandNested: true)
        }
    }
    
    func questionListCellDidSelectNegativeAnswer(forQuestion question: DailyQuestionVM) {
        if let parent = questions.first(where: { $0.nestedQuestion == question.origin }), let index = questions.firstIndex(of: parent) {
            questions[index].nestedQuestion?.submittedAnswer = AnswerOption.negative
        } else {
            guard let index = questions.firstIndex(of: question) else { return }
            questions[index].submittedAnswer = AnswerOption.negative
            checkForNestedQuestions(question: questions[index], shouldExpandNested: false)
        }
    }

    func questionListCell(inputFieldTextDidChange text: String, forQuestion question: DailyQuestionVM) {
        if let parent = questions.first(where: { $0.nestedQuestion == question.origin }), let index = questions.firstIndex(of: parent) {
            questions[index].nestedQuestion?.inputDataAnswer = text
        } else {
            guard let index = questions.firstIndex(of: question) else { return }
            questions[index].inputDataAnswer = text
        }
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
    
    func questionCheckboxCell(didSelectAnswer answer: Answer, forQuestion question: DailyQuestion) {
        guard let index = questions.firstIndex(where: {$0.origin == question}) else { return }
        questions[index].submittedAnswer = answer
    }
}

// MARK: Continue button delegate

extension DailyQuestionsViewController: ActionButtonCellDelegate {
    func actionButtonDidTap(cell: ActionButtonCell, button: GradientButton) {
        sendResults()
    }
}
