//
//  DailyQuestionsViewController.swift
//  Covid19VOCAAi
//
//  Created by Yevhenii on 07.05.2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit
import SVProgressHUD

class DailyQuestionsViewController: UIViewController {
    
    static func initialization() -> DailyQuestionsViewController {
        return UIStoryboard.init(name: "PersonalDetails", bundle: nil).instantiateViewController(withIdentifier: "DailyQuestionsViewController") as! DailyQuestionsViewController
    }
    @IBOutlet weak var tableView: UITableView!
    
    var questions = [DailyQuestionVM]() {
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
    
    func isValid() -> Bool {
        
        var validationResult = false
        
        questions.forEach { (question) in
            switch question.type {
            case .yesNoWithInput:
                validationResult = question.submittedAnswer != nil && question.inputDataAnswer != nil
            default:
                validationResult = question.submittedAnswer != nil
            }
        }
        return validationResult
    }
    
    func sendResults() {
        guard isValid() else { return }
        
        SVProgressHUD.show()
        APIManager.shared.sendMeasurment(method: .post, params:
            ["tag": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
             "tempMeasurement": "36",
             "exposureDate": "2020-05-02",
             "positiveTestDate": "2020-05-02",
             "negativeTestDate": "2020-05-02",
             "generalFeeling": "SAME"]) { [weak self] (result) in
                self?.presenter?.handleResult(result: result, type: DailyQuestionsDTO.self, completion: { [weak self] (res) in
                    SVProgressHUD.hideOnMain()
                    self?.navigate(.dailyQuestionnaire2)
                })
        }
    }
}

extension DailyQuestionsViewController: DailyQuestionsDelegate {
    func dailyQuestionsPresenter(didUpdateWith questions: [DailyQuestionVM]) {
        self.questions = questions
    }
}
