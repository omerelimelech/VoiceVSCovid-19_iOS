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
            reload()
        }
    }
    
    var rows = [Row]()
    
    var presenter: DailyQuestionsPresenter?
    
    var continueButtonIndexPath: IndexPath {
        return IndexPath(row: rows.count, section: 0)
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
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: StringHelper.stringForClass(QuestionListCell.self), bundle: nil), forCellReuseIdentifier: "QuestionListCell")
        tableView.register(UINib(nibName: StringHelper.stringForClass(ActionButtonCell.self), bundle: nil), forCellReuseIdentifier: "ActionButtonCell")
        tableView.register(UINib(nibName: "QuestionCheckboxCell", bundle: nil), forCellReuseIdentifier: QuestionCheckboxCell.ReuseIdentifier)
    }
    
    func isValid() -> Bool {
        
        let validationArray = rows.compactMap { (row) -> Bool in
            let question = row.question
            switch question.origin.questionTitle {
            case .tempMeasurement:
                if (question.submittedAnswer as? AnswerOption) == .positive {
                    return question.inputDataAnswer != nil
                } else {
                    return question.submittedAnswer != nil
                }
            case .exposureDate:
                
                if (question.submittedAnswer as? AnswerOption) == .positive {
                    return question.inputDataAnswer != nil
                } else {
                    return question.submittedAnswer != nil
                }
            case .testedForPositiveCovid:
                return question.submittedAnswer != nil
            case .isResultPositive:
                return question.submittedAnswer != nil && question.inputDataAnswer != nil
            case .generalFeeling:
                return question.submittedAnswer != nil
            }
        }
        
        return !validationArray.contains(false)
    }
    
    func sendResults() {
        guard isValid() else { return }
        
        var measurementDTO = DailyQuestionsDTO(tempMeasurement: nil,
                                               exposureDate: nil,
                                               positiveTestDate: nil,
                                               negativeTestDate: nil,
                                               generalFeeling: nil)
        
        measurementDTO.tag = "3fa85f64-5717-4562-b3fc-2c963f66afa6"
        measurementDTO.filledOn = serverDateFromCurrentDate()
        
        rows.forEach { (row) in
            
            let question = row.question
            
            switch question.origin.questionTitle {
            case .tempMeasurement:
                if let temperature = question.inputDataAnswer {
                    measurementDTO.tempMeasurement = temperature
                }
            case .exposureDate:
                if let exposureDate = question.inputDataAnswer, let date = serverDateFromCurrent(dateString: exposureDate) {
                    measurementDTO.exposureDate = date
                }
            case .testedForPositiveCovid: break
            case .isResultPositive:
                guard   let answer = question.submittedAnswer as? AnswerOption,
                        let inputResult = question.inputDataAnswer,
                        let date = serverDateFromCurrent(dateString: inputResult) else { return }
                switch answer {
                case .positive:
                    measurementDTO.positiveTestDate = date
                case .negative:
                    measurementDTO.negativeTestDate = date
                }
            case .generalFeeling:
                measurementDTO.generalFeeling = question.submittedAnswer as? Feeling
            }
        }
        
        SVProgressHUD.show()
        
        let postDTO = try? measurementDTO.asDictionary()
        
        APIManager.shared.sendMeasurment(method: .post, params: postDTO) { [weak self] (result) in
            
                self?.presenter?.handleResult(result: result, type: DailyQuestionsDTO.self, completion: { [weak self] (res) in
                    SVProgressHUD.hideOnMain()
                    self?.navigate(.dailyQuestionnaire2)
                })
        }
    }
    
    func serverDateFromCurrentDate() -> String {
        let desiredDateFormat = "dd-MM-yyyy"
        let formatter = DateFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        formatter.calendar = Calendar.autoupdatingCurrent
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.dateFormat = desiredDateFormat
        return formatter.string(from: Date())
    }
    
    func serverDateFromCurrent(dateString: String) -> String? {
        
        let currentDateFormat = "dd/MM/yyyy"
        let desiredDateFormat = "yyyy-MM-dd"
        let formatter = DateFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        formatter.calendar = Calendar.autoupdatingCurrent
        formatter.timeZone = TimeZone.autoupdatingCurrent
        
        formatter.dateFormat = currentDateFormat
        if let desiredDate = formatter.date(from: dateString) {
            formatter.dateFormat = desiredDateFormat
            return formatter.string(from: desiredDate)
        } else {
            return nil
        }
    }
}

// MARK: Rows

extension DailyQuestionsViewController {
    
    func reload() {
        var rows = [Row]()
        
        for question in questions {
            rows.append(Row(question: question))
            
            if let nested = question.nestedQuestion, question.currentlyShowsNested {
                let vm = DailyQuestionVM(origin: nested)
                let row = Row(question: vm)
                rows.append(row)
            }
        }
        self.rows = rows
        tableView.reloadData()
    }
    
    func checkForNestedQuestions(question: DailyQuestionVM, shouldExpandNested: Bool) {
        guard question.nestedQuestion != nil else { return }
        if shouldExpandNested {
            guard let index = questions.firstIndex(of: question) else { return }
            questions[index].currentlyShowsNested = true
            tableView.scrollToRow(at: IndexPath(row: index + 1, section: 0), at: .bottom, animated: true)
        } else {
            questions[questions.firstIndex(of: question)!].currentlyShowsNested = false
        }
    }
    
    struct Row {
        let question: DailyQuestionVM
    }
}

extension DailyQuestionsViewController: DailyQuestionsDelegate {
    func dailyQuestionsPresenter(didUpdateWith questions: [DailyQuestionVM]) {
        self.questions = questions
    }
}
