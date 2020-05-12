//
//  PersonalDetails2ViewController.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 11/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

class PersonalDetails2ViewController: UIViewController {

    @IBOutlet weak var weightTitlePickerView: TitlePickerView!
    @IBOutlet weak var heightTitlePickerView: TitlePickerView!
    @IBOutlet weak var continueButton: VoiceUpContinueButton!
    @IBOutlet weak var ageTitlePickerView: TitlePickerView!
    @IBOutlet weak var femaleButton: RadioButton!
    @IBOutlet weak var maleButton: RadioButton!
    
    weak var delegate: PersonalDetailsDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        [weightTitlePickerView, heightTitlePickerView, ageTitlePickerView].forEach({$0?.onFillData = { (data) in
            self.checkData()
            }})
        
    }
    
    private func checkData(){
        if weightTitlePickerView.pickerTextField.text != "" && self.heightTitlePickerView.pickerTextField.text != ""  && ageTitlePickerView.pickerTextField.text != "" && (self.maleButton.isSelected || self.femaleButton.isSelected){
               self.continueButton.setEnabled()
           }else{
               self.continueButton.setDisabled()
           }
       }

    @IBAction func continueTapped(_ sender: GradientButton) {
        self.delegate?.personalDetailsViewController(self, didTapContiueWith: [PersonalDetailsKey.sex.rawValue: maleButton.isSelected ? Sex.male : Sex.female, PersonalDetailsKey.age.rawValue : ageTitlePickerView.pickerTextField.text, PersonalDetailsKey.weight.rawValue : weightTitlePickerView.pickerTextField.text, PersonalDetailsKey.height.rawValue : heightTitlePickerView.pickerTextField.text])
    }
    @IBAction func genderTapped(_ sender: RadioButton) {
        // MALE TAG - 1
        // FEMALE TAG - 2
        switch sender.tag {
        case 1:
            maleButton.isSelected = true
            femaleButton.isSelected = false
        case 2:
            maleButton.isSelected = false
            femaleButton.isSelected = true
        default:
            return
        }
        maleButton.select()
        femaleButton.select()
        checkData()
    }
    
}

extension PersonalDetails2ViewController: UITextFieldDelegate {
    
    
    
}
