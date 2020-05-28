//
//  DailyQuestion.swift
//  Covid19VOCAAi
//
//  Created by Yevhenii on 10.05.2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation

// MARK: Question - related types

struct DailyQuestion: Equatable {
    
    static func == (lhs: DailyQuestion, rhs: DailyQuestion) -> Bool {
        return lhs.questionTitle.localized == rhs.questionTitle.localized
    }
    
    enum QuestionTitle: String {
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
    
    var text: String {
        return questionTitle.localized
    }
    
    let questionTitle: QuestionTitle
    let type: QuestionType
    var answerOptions: [Answer]
    var isNested: Bool = false
    var submittedAnswer: Answer? = nil
    var inputDataAnswer: String? = nil
}

protocol Answer {
    var localizedAnswer: String { get }
    func isEqual(to answer: Answer) -> Bool
}

// MARK: Answer

enum AnswerOption: Answer {
    
    func isEqual(to answer: Answer) -> Bool {
        return self == answer as? AnswerOption
    }
        
    case positive
    case negative
    
    var localizedAnswer: String {
        switch self {
        case .positive: return "Yes"
        case .negative: return "No"
        }
    }
}

enum Feeling: String, Codable, Answer {
    case same = "SAME"
    case better = "BETTER"
    case worse = "WORSE"
    
    var localizedAnswer: String {
        switch self {
            case .same: return "Same"
            case .better: return "Better"
            case .worse: return "Worse"
        }
    }
    
    func isEqual(to answer: Answer) -> Bool {
        return self == answer as? Feeling
    }
}

// MARK: View Model

struct DailyQuestionVM: Equatable {
    
    static func == (lhs: DailyQuestionVM, rhs: DailyQuestionVM) -> Bool {
        return lhs.origin == rhs.origin
    }
    
    var origin: DailyQuestion
    var nestedQuestion: DailyQuestion? = nil
    var currentlyShowsNested = false
    
    var type: DailyQuestion.QuestionType {
        return origin.type
    }
    
    var submittedAnswer: Answer? {
        get {
            return origin.submittedAnswer
        }
        set {
            origin.submittedAnswer = newValue
        }
    }
    
    var inputDataAnswer: String? {
        get {
            return origin.inputDataAnswer
        }
        set {
            origin.inputDataAnswer = newValue
        }
    }
    
    var isNested: Bool {
        return origin.isNested
    }
}

// MARK: Server Model

struct DailyQuestionsDTO: Codable {
    var id: Int = 0
    var filledOn: String = ""
    var tag: String = ""
    var tempMeasurement: String?
    var exposureDate: String?
    var positiveTestDate: String?
    var negativeTestDate: String?
    var generalFeeling: Feeling?
}


