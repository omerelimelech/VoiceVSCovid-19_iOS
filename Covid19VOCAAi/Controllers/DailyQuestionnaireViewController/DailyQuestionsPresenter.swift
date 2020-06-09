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
    
        DailyQuestionVM(origin: DailyQuestion(questionTitle: .tempMeasurement, type: .yesNoWithInput(inputType: .number(inputFieldName: "Temperature:")), answerOptions: [AnswerOption.positive, AnswerOption.negative])),
        
        DailyQuestionVM(origin: DailyQuestion(questionTitle: .exposureDate, type: .yesNoWithInput(inputType: .date(inputFieldName: "Date:")), answerOptions: [AnswerOption.positive, AnswerOption.negative])),
        
        DailyQuestionVM(origin: DailyQuestion(questionTitle: .testedForPositiveCovid, type: .yesNoType, answerOptions: [AnswerOption.positive, AnswerOption.negative]), nestedQuestion: DailyQuestion(questionTitle: .isResultPositive, type: .yesNoWithInput(inputType: .date(inputFieldName: "Date of test")), answerOptions: [AnswerOption.positive, AnswerOption.negative], isNested: true)),
        
        DailyQuestionVM(origin: DailyQuestion(questionTitle: .generalFeeling, type: .checkboxed,
                                                answerOptions: [Feeling.same, Feeling.better, Feeling.worse]))
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
    
    func sendMeasurement(measurementObject: DailyQuestionsDTO, completion: @escaping completion) {
        let postDTO = try? measurementObject.asDictionary()
        APIManager.shared.sendMeasurment(method: .post, params: postDTO, completion: completion)
    }
}

