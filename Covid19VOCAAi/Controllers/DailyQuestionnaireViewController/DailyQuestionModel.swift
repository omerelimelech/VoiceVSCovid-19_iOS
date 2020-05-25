//
//  DailyQuestion.swift
//  Covid19VOCAAi
//
//  Created by Yevhenii on 10.05.2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation

struct DailyQuestion {
    
    enum Question: String {
        case tempMeasurement
        case exposureDate
        case testedForPositiveCovid
        case isResultPositive
        case generalFeeling
        
        var localized: String {
            switch self {
            case .tempMeasurement:
                return "Do you have fever?"
            case .exposureDate:
                return "Have you been exposed to a verified patient?"
            case .testedForPositiveCovid:
                return "Have you checked and received a positive answer to Covid-19?"
            case .isResultPositive:
                return "Was the result positive?"
            case .generalFeeling:
                return "How are you feeling today?"
            }
        }
    }
    
    enum RelatedData {
        case number(inputFieldName: String)
        case date(inputFieldName: String)
    }
    
    enum QuestionType {
        case yesNoType
        case checkboxed
        case yesNoWithInput(inputType: RelatedData)
    }
    
    enum Feeling: String, Codable {
        case same = "SAME"
        case better = "BETTER"
        case worse = "WORSE"
    }
    
    var text: String {
        return question.localized
    }
    
    let question: Question
    let type: QuestionType
    var answerOptions: [String]
    var isNested: Bool = false
    var submittedAnswer: String? = nil
    var inputDataAnswer: String? = nil
}

struct DailyQuestionVM {
    var question: DailyQuestion
    var nestedQuestion: DailyQuestion? = nil
    
    var type: DailyQuestion.QuestionType {
        return question.type
    }
    
    var submittedAnswer: String? {
        get {
            return question.submittedAnswer
        }
        set {
            question.submittedAnswer = newValue
        }
    }
    
    var inputDataAnswer: String? {
        get {
            return question.inputDataAnswer
        }
        set {
            question.inputDataAnswer = newValue
        }
    }
}

struct DailyQuestionsDTO: Codable {
    
    enum Feeling: String, Codable {
        case same = "SAME"
        case better = "BETTER"
        case worse = "WORSE"
    }
    
    let id: Int
    let filledOn: String
    let tag: String
    let tempMeasurement: String
    let exposureDate: String
    let positiveTestDate: String
    let negativeTestDate: String
    let generalFeeling: Feeling
}


