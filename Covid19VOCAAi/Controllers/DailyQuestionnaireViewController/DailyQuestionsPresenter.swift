//
//  DailyQuestionsPresenter.swift
//  Covid19VOCAAi
//
//  Created by Yevhenii on 09.05.2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

protocol DailyQuestionsDelegate: class {
    func dailyQuestionsPresenter(didUpdateWith questions: [DailyQuestion])
}

class DailyQuestionsPresenter: BasePresenter{
    
    weak var delegate: DailyQuestionsDelegate?
    
    var dailyQuestionsDataSource = [
        
        DailyQuestion(type: .yesNoWithInput(inputType: .number(inputFieldName: "Temperature:")),
                      text: "Do you have a fever?",
                      answerOptions: ["Yes", "No"]),
        DailyQuestion(type: .yesNoWithInput(inputType: .date(inputFieldName: "Date:")),
                      text: "Have you been exposed as a verified corona patient?",
                      answerOptions: ["Yes", "No"]),
        DailyQuestion(type: .yesNoWithInput(inputType: .date(inputFieldName: "Date of test")),
                      text: "Have you been checked for corona?",
                      answerOptions: ["Yes", "No"]),
        DailyQuestion(type: .checkboxed,
                      text: "How are you feeling today?",
                      answerOptions: ["Same", "Better", "Worse"])
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

