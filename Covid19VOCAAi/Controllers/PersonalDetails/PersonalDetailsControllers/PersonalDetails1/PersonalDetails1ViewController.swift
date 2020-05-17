//
//  PersonalDetails1ViewController.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 01/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

protocol PersonalDetailsDelegate: class{
    func personalDetailsViewController(_ controller: UIViewController, didTapContiueWith values: [String: Any?])
    func personalDetailsViewController(_ controller: UIViewController, didFinishPickingDiseases values: [String])
    func personalDetailsDoneSuccessfully()
}
extension PersonalDetailsDelegate {
    func personalDetailsViewController(_ controller: UIViewController, didTapContiueWith values: [String: Any?]) {}
    func personalDetailsViewController(_ controller: UIViewController, didFinishPickingDiseases values: [String]) {}
}
class PersonalDetails1ViewController: UIViewController {

    @IBOutlet weak var phoneNumberPickerView: TitlePickerView!
    
    
    @IBOutlet weak var countryPickerView: CountriesPickerView!
    
    weak var delegate: PersonalDetailsDelegate?
    
    @IBOutlet weak var continueButton: VoiceUpContinueButton!
    var country: String = "IL"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryPickerView.configure(with: "Country", dataSource: FormModel().countryDataSource, isPrimary: false)
        phoneNumberPickerView.onFillData = { (text) in
            self.checkData()
        }
        
        countryPickerView.onFillData = { (country) in
            self.checkData()
        }
    }
    
    
    private func checkData(){
        if phoneNumberPickerView.pickerTextField.text != "" && self.countryPickerView.pickerTextField.text != "" {
            self.continueButton.setEnabled()
        }else{
            self.continueButton.setDisabled()
        }
    }
    
    @IBAction func continueButtonTapped(_ sender: GradientButton) {
        self.delegate?.personalDetailsViewController(self, didTapContiueWith: [PersonalDetailsKey.phoneNumber.rawValue : phoneNumberPickerView.pickerTextField.text, PersonalDetailsKey.country.rawValue: country])
    }
}



class VoiceUpContinueButton: GradientButton {
    
    override var isHighlighted: Bool{
        didSet{
            if isHighlighted{
                addShadow()
            }else{
                removeShadow()
            }
        }
    }
    func setDisabled(){
        startColor = .disabledGray
        endColor = .disabledGray
        isEnabled = false
    }
    
    func setClear(withColor color: UIColor = .white){
        startColor = color
        endColor = color
    }
    func setEnabled(){
        startColor = .lightBlue
        endColor = .softenBlue
        horizontalMode = true
        isEnabled = true
    }
    
    
    
}
