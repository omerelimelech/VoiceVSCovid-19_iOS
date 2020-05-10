//
//  DailyQuestionsViewController+Table.swift
//  Covid19VOCAAi
//
//  Created by Yevhenii on 09.05.2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

// MARK: Table-view related

extension DailyQuestionsViewController {
    
    struct Row {
        enum RowType {
            case optionQuestion
            case optionTextFieldQuestion
            case optionDatePickerQuestion
            case continueButton
        }
        
        let type: RowType
    }
    
    func reloadTableData() {
        var rows = [Row]()
        for _ in 0..<3 {
            rows.append(Row(type: .optionQuestion))
        }
        rows.append(Row(type: .continueButton))
        self.tableRows = rows
    }
}

extension DailyQuestionsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowType = tableRows[indexPath.row].type
        
        switch rowType {
        case .optionQuestion, .optionTextFieldQuestion, .optionDatePickerQuestion:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionListCell.ReuseIdentifier, for: indexPath) as? QuestionListCell else { return UITableViewCell() }
                cell.delegate = self
                cell.config = QuestionListCell.Config(title: "How do you feel?",
                                                      yesButtonText: "Yes",
                                                      noButtonText: "No",
                                                      textFieldDescription: nil)
                return cell
        case .continueButton:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ActionButtonCell.ReuseIdentifier, for: indexPath) as? ActionButtonCell else { return UITableViewCell() }
            cell.actionButton.setTitle("Continue", for: .normal)
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
    func didSelectYesOption() {
        print("YES")
    }
    
    func didSelectNoOption() {
        print("NO")
    }
    
    func inputFieldTextDidChange(text: String) {
        print("Temperature: \(text)")
    }
}
