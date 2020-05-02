//
//  PersonalDetails1ViewController.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 01/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

protocol PersonalDetailsDelegate{
    func personalDetailsViewController(_ controller: UIViewController, didTapContiueWith values: [String: Any])
}

class PersonalDetails1ViewController: UIViewController {

    @IBOutlet weak var phoneNumberPickerView: TitlePickerView!
    
    
    @IBOutlet weak var countryPickerView: TitlePickerView!
    
    var delegate: PersonalDetailsDelegate?
    
    @IBOutlet weak var continueButton: VoiceUpContinueButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        self.delegate?.personalDetailsViewController(self, didTapContiueWith: [:])
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
    
    func setEnabled(){
        startColor = .lightBlue
        endColor = .softenBlue
        horizontalMode = true
        isEnabled = true
    }
    
    
    
}
