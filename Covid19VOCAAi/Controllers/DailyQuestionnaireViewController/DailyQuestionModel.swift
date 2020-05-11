//
//  DailyQuestion.swift
//  Covid19VOCAAi
//
//  Created by Yevhenii on 10.05.2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation

struct DailyQuestion {
    enum FeedbackType {
        case textInput
        case date
    }
    let text: String
    var isYes: Bool?
    var feedbackType: FeedbackType
}

class DailyQuestionModel {
    
    var dailyQuestionsDataSource = [
        DailyQuestion(text: "Have you checked your fever today?", isYes: nil, feedbackType: .textInput),
        DailyQuestion(text: "Have you been exposed as a verified patient?", isYes: nil, feedbackType: .date),
        DailyQuestion(text: "Have you been tested and received a lab result for Corona?", isYes: nil)
    ]
}

