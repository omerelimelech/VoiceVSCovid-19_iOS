//
//  DailyQuestionsPresenter.swift
//  Covid19VOCAAi
//
//  Created by Yevhenii on 09.05.2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

protocol DailyQuestionsDelegate: class {
    func dailyQuestionsPresenter(didUpdateWith questions: [DailyQuestionVM])
}

class DailyQuestionsPresenter: BasePresenter{
    
    weak var delegate: DailyQuestionsDelegate?
    
    var dailyQuestionsDataSource = [
        
        DailyQuestionVM(question: DailyQuestion(question: .tempMeasurement, type: .yesNoWithInput(inputType: .number(inputFieldName: "Temperature:")), answerOptions: ["Yes", "No"])),
        
        DailyQuestionVM(question: DailyQuestion(question: .exposureDate, type: .yesNoWithInput(inputType: .date(inputFieldName: "Date:")), answerOptions: ["Yes", "No"])),
        
        DailyQuestionVM(question: DailyQuestion(question: .testedForPositiveCovid, type: .yesNoType, answerOptions: ["Yes", "No"]), nestedQuestion: DailyQuestion(question: .isResultPositive, type: .yesNoWithInput(inputType: .date(inputFieldName: "Date of test")), answerOptions: ["Yes", "No"], isNested: true)),
        
        DailyQuestionVM(question: DailyQuestion(question: .generalFeeling, type: .checkboxed,
        answerOptions: ["Same", "Better", "Worse"]))
    ]
    
    init(with delegate : DailyQuestionsDelegate){
        self.delegate = delegate
    }
    
    func questionnaireHeaderViewTitle() -> String {
        return "How do you feel today?".localized()
    }
    
    func getDailyQuestions() {
        delegate?.dailyQuestionsPresenter(didUpdateWith: dailyQuestionsDataSource)
    }
}

