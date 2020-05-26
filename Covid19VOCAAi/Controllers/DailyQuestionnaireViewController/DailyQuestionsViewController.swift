//
//  DailyQuestionsViewController.swift
//  Covid19VOCAAi
//
//  Created by Yevhenii on 07.05.2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit
import Firebase

class DailyQuestionsViewController: UIViewController {
    
    
    static func initialization(full_flow:Bool = false) -> DailyQuestionsViewController? {
        guard let vc =  UIStoryboard.init(name: "PersonalDetails", bundle: nil).instantiateViewController(withIdentifier: "DailyQuestionsViewController") as? DailyQuestionsViewController
            else { return nil}
        vc.fullFlowAnalytics = full_flow
        return vc
    }
    var fullFlowAnalytics:Bool = false;
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
        Analytics.logEvent("daily_questionnaire",parameters: [
        "full_flow": fullFlowAnalytics as NSObject])
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
        let has_fever = questions[0].submittedAnswer ?? ""
        let exposed = questions[1].submittedAnswer ?? ""
        let covid_positive = questions[2].submittedAnswer ?? ""
        Analytics.logEvent("daily_questionnaire_continue_tapped",parameters: [
        "has_fever": has_fever as NSObject,
        "exposed":exposed as NSObject,
        "covid_positive":covid_positive as NSObject])
        navigate(.dailyQuestionnaire2)
    }
}

extension DailyQuestionsViewController: DailyQuestionsDelegate {
    func dailyQuestionsPresenter(didUpdateWith questions: [DailyQuestion]) {
        self.questions = questions
    }
}
