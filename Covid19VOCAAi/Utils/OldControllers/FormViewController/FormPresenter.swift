//
//  FormPresenter.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 07/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation



class FormPresenter: BasePresenter{
    
    weak var delegate: FormDelegate?
    
    let model = FormModel()
    init(with delegate : FormDelegate){
        self.delegate = delegate
    }
    
    func configureAge(view: ConfigureView) {
        configure(view: view, with: "Age".localized(), dataSource: nil, isPrimary: true)
    }
    
    func configureGender(view: ConfigureView){ 
        configure(view: view, with: "Gender".localized(), dataSource: model.genderDataSource, isPrimary: true)
    }
    
    func configureCountry(view: CountriesPickerView){
        view.configure(with: "Country".localized(), dataSource: model.countryDataSource, isPrimary: true)
//          (view: view, with: "Country".localized(), dataSource: model.countryDataSource, isPrimary: true)
    }
    
    func configureDiagnose(view: ConfigureView){
        configure(view: view, with: "Have you been diagnosed with any of the following conditions?".localized(), dataSource: model.diagnoseDataSource, isPrimary: false)
    }
    func configureSmoke(view: ConfigureView){
        self.configure(view: view, with: "Do you smoke?".localized(), dataSource: model.smokeDataSource, isPrimary: false)
    }
    
    func configureCurrentStatus(view: ConfigureView){
        configure(view: view, with: "What is your current status?".localized(), dataSource: model.currentStatusDataSource, isPrimary: true)
    }
    
    func configureAreYouDisgnoseDataSource(view: ConfigureView){
        configure(view: view, with: "Were you diagnosed with Respiratory disease?".localized(), dataSource: model.areYouDisgnoseDataSource, isPrimary: true)
    }
    
    func configureSympthoms(view: ConfigureView){
        configure(view: view, with: "Are you currently experiencing any of the following symptoms:".localized(), dataSource: model.symptomsDataSource, isPrimary: false)
    }
    
    
    func sendForm(withJson json:[String: Any]){
        model.sendForm(withJson: json) { (result) in
            self.handleResult(result: result, type: Submission.self) { (submission) in
                guard let submission = submission else {
                    return //error
                }
                self.delegate?.formPresenter(self, didPostSubmission: submission)
            }
        }
    }
    
    
    
    
    private func configure(view: ConfigureView, with title: String, dataSource: [LocalizedEnum]?, isPrimary: Bool){
        view.configure(with: title, dataSource: dataSource, isPrimary: isPrimary)
    }
    
}
