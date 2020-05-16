//
//  DailyQuestionsViewController.swift
//  Covid19VOCAAi
//
//  Created by Yevhenii on 07.05.2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

class DailyQuestionsViewController: UIViewController {
    
    
    static func initialization() -> DailyQuestionsViewController {
        return UIStoryboard.init(name: "PersonalDetails", bundle: nil).instantiateViewController(withIdentifier: "DailyQuestionsViewController") as! DailyQuestionsViewController
    }
    @IBOutlet weak var tableView: UITableView!
    
    var questions = [DailyQuestion]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var presenter: DailyQuestionsPresenter?
    
    var continueButtonIndexPath: IndexPath {
        return IndexPath(row: questions.count, section: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = DailyQuestionsPresenter(with: self)
        configure()
        presenter?.getDailyQuestions()
    }
    
    private func configure() {
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 110
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: StringHelper.stringForClass(QuestionListCell.self), bundle: nil), forCellReuseIdentifier: "QuestionListCell")
        tableView.register(UINib(nibName: StringHelper.stringForClass(ActionButtonCell.self), bundle: nil), forCellReuseIdentifier: "ActionButtonCell")
        tableView.register(UINib(nibName: "QuestionCheckboxCell", bundle: nil), forCellReuseIdentifier: QuestionCheckboxCell.ReuseIdentifier)
    }
    
    func sendResults() {
        print(questions)
        navigate(.dailyQuestionnaire2)
    }
}

extension DailyQuestionsViewController: DailyQuestionsDelegate {
    func dailyQuestionsPresenter(didUpdateWith questions: [DailyQuestion]) {
        self.questions = questions
    }
}
