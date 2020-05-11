//
//  DailyQuestionsPresenter.swift
//  Covid19VOCAAi
//
//  Created by Yevhenii on 09.05.2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

protocol DailyQuestionsDelegate: class {
    func formPresenterDidPostQuestions(_ presenter: DailyQuestionsPresenter)
    func formPresenter(_ presenter: DailyQuestionsPresenter, didFailPostSubmissionWith error: Error)
}

class DailyQuestionsPresenter: BasePresenter{
    
    weak var delegate: DailyQuestionsDelegate?
    
    let model = DailyQuestionModel()
    
    init(with delegate : DailyQuestionsDelegate){
        self.delegate = delegate
    }
    
    func questionnaireHeaderViewTitle() -> String {
        return "How do you feel today?".localized()
    }
    
    
}

