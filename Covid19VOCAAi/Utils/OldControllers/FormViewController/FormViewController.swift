//
//  ViewController.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 05/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit
import SVProgressHUD
import PKHUD
class FormViewController: UIViewController {
    @IBOutlet weak var agePickerView: TitlePickerView!
    @IBOutlet weak var genderPickerView: TitlePickerView!
    @IBOutlet weak var countryPickerView: CountriesPickerView!
    @IBOutlet weak var heightInputView: MultiInputView!
    
    @IBOutlet weak var currentStatusPickerView: TitlePickerView!
    @IBOutlet weak var smokePickerView: TitlePickerView!
    @IBOutlet weak var diagnoseMultiSelectionView: MultipleSelectionView!
    
    @IBOutlet weak var areYouDiagnosedPickerView: TitlePickerView!
    
    @IBOutlet weak var bodyTempInputView: MultiInputView!
    @IBOutlet weak var simptomesExperienceMultiSelectionView: MultipleSelectionView!
    
    
    var presenter: FormPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = FormPresenter(with: self)
        presenter?.configureAge(view: agePickerView)
        presenter?.configureGender(view: genderPickerView)
        heightInputView.currentType = .height
        presenter?.configureCountry(view: countryPickerView)
        presenter?.configureDiagnose(view: diagnoseMultiSelectionView)
        presenter?.configureSmoke(view: smokePickerView)
        presenter?.configureCurrentStatus(view: currentStatusPickerView)
        presenter?.configureAreYouDisgnoseDataSource(view: areYouDiagnosedPickerView)
        presenter?.configureSympthoms(view: simptomesExperienceMultiSelectionView)
        bodyTempInputView.currentType = .bodyTemp
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      
        
    }
    
    @IBAction func dismissTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func submitTapped(_ sender: UIButton) {
        presenter?.sendForm(withJson: buildData())
        HUD.show(.progress)
    }
}

extension FormViewController {
    
    func buildData() -> [String: Any] {
        return ["deviceId": UIDevice.current.identifierForVendor?.uuidString ?? "",
            "formRevision": 2,
            "formData": [
                "height": heightInputView.getHeightData(),
                "age": agePickerView.getData(),
                "gender": genderPickerView.getData(),
                "country": countryPickerView.getData(),
                "address": "a",
                "city": "b",
                "zipcode": "1234",
                "backgroundDiseases": [
                    diagnoseMultiSelectionView.getData()
                ],
                "smokingHabits": smokePickerView.getData(),
                "status": currentStatusPickerView.getData(),
                "covid19": [
                    "currentFever": bodyTempInputView.getBodyTempData(),
                    "diagnosedCovid19": areYouDiagnosedPickerView.getData(),
                    "currentSymptoms": [ simptomesExperienceMultiSelectionView.getData()
                    ]
                ]
            ]
        ] as [String : Any]
    }
    
    
}

extension FormViewController: FormDelegate{
    func formPresenter(_ presenter: FormPresenter, didPostSubmission submission: Submission) {
        HUD.hide()
        GlobalData.shared.currentSubmissionId = submission.submissionId
        let ins = RecordInstructions(stage: .cough)
        guard let vc = RecordViewController.initialization(instructions: ins, recordNumber: 1) else   {return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func formPresenter(_ presenter: FormPresenter, didFailPostSubmissionWith error: Error) {
        HUD.hide()
    }
    
    
}
