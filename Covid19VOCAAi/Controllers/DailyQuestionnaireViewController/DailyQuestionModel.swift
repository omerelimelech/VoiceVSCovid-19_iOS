//
//  DailyQuestion.swift
//  Covid19VOCAAi
//
//  Created by Yevhenii on 10.05.2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation

struct DailyQuestion {
    
    enum RelatedData {
        case number(inputFieldName: String)
        case date(inputFieldName: String)
    }
    
    enum QuestionType {
        case yesNoType
        case checkboxed
        case yesNoWithInput(inputType: RelatedData)
    }
    
    let type: QuestionType
    let text: String
    var answerOptions: [String]
    var submittedAnswer: String? = nil
    var inputDataAnswer: String? = nil
}


