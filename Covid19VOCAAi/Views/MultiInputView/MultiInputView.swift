//
//  MultiInputView.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 05/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation
import UIKit


enum MultiInputViewType{
    case height
    case bodyTemp
}

enum TempertureType : String, LocalizedEnum{
    case celsious = "Celsious"
    case fahrenheit = "Fahrenheit"
    
    func localizedString() -> String {
        return self.rawValue.localized()
    }
    static var allValues: [LocalizedEnum]{
        return [TempertureType.celsious, TempertureType.fahrenheit]
    }
    var englishValue: String{
        return self.rawValue
    }
}

enum HeightType : String, LocalizedEnum{
    case feet = "Feet"
    case centimeters = "Centimeters"
    
    func localizedString() -> String {
        return self.rawValue.localized()
    }
    static var allValues: [LocalizedEnum]{
        return [HeightType.centimeters, HeightType.feet]
    }
    var englishValue: String{
        return self.rawValue
    }
}
class MultiInputView: BaseView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var leftTextField: UITextField!
    
    @IBOutlet weak var centerTextField: UITextField!
    
    @IBOutlet weak var rightPicker: UITextField!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var dataSource = [LocalizedEnum]()
    let pickerView = UIPickerView()
    var currentType : MultiInputViewType = .height {
        didSet{
            switch currentType {
            case .height:
                setupHeight()
            case .bodyTemp:
                setupBodyTemp()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialConfig()
        
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialConfig()
    }
    
    override func initialConfig() {
        super.initialConfig()
        isHidden = false
        setupPicker()
        
    }
    
    
    func setupHeight(){
        self.titleLabel.text = "Height".localized()
        self.dataSource = HeightType.allValues
        self.pickerView.reloadAllComponents()
        self.pickerView.selectRow(0, inComponent: 0, animated: false)
        rightPicker.text = HeightType.feet.localizedString()
        leftTextField.placeholder = HeightType.feet.localizedString()
        centerTextField.placeholder = "Inches".localized()
        self.centerTextField.isHidden = false
    }

    
    func setupBodyTemp(){
        self.centerTextField.isHidden = true
        self.titleLabel.text = "Current body temperature".localized()
        self.dataSource = TempertureType.allValues
        self.pickerView.reloadAllComponents()
        self.pickerView.selectRow(0, inComponent: 0, animated: false)
        rightPicker.text = TempertureType.celsious.localizedString()
        leftTextField.placeholder = ""
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row].localizedString()
    }
    
    
    func setupPicker() {
        pickerView.delegate = self
        pickerView.dataSource = self
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.width, height: 50))
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(selectItem))
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        toolBar.setItems([space, space, button], animated: false)
        rightPicker.inputView = pickerView
        rightPicker.inputAccessoryView = toolBar
        pickerView.reloadAllComponents()
    }
    
    @objc func selectItem() {
        rightPicker.text = dataSource[pickerView.selectedRow(inComponent: 0)].localizedString()
        switch currentType {
        case .height:
            switch dataSource[pickerView.selectedRow(inComponent: 0)].localizedString(){
            case "Feet".localized():
                centerTextField.isHidden = false
                leftTextField.placeholder = "Feet".localized()
                centerTextField.placeholder = "Inches".localized()
            case "Centimeters".localized():
                leftTextField.placeholder = ""
                centerTextField.isHidden = true
                
            default:
                return
            }
        case .bodyTemp:
            rightPicker.text = dataSource[self.pickerView.selectedRow(inComponent: 0)].localizedString()
        }
        
        endEditing(true)
    }
    
    func getHeightData() -> [String: Any]{
        if currentType == .height{
            guard let type = dataSource[pickerView.selectedRow(inComponent: 0)] as? HeightType else {return [:]}
            switch type {
            case .feet:
                let unit = type.englishValue
                let feet = Int(leftTextField.text ?? "0") ?? 0
                let inches = Int(centerTextField.text ?? "0") ?? 0 / 100
                let value = Double(feet + inches)
                return ["unit": unit, "value" : value]
            case .centimeters:
                let unit = type.englishValue
                let value = Int(leftTextField.text ?? "0")
                return ["unit": unit, "value" : value]
            }
            
            let temp = leftTextField.text ?? "0.0"
            return  ["unit": type, "value": Float(temp) ?? 0.0]
        }
        return [:]
    }
    
    func getBodyTempData() -> [String: Any]{
        if currentType == .bodyTemp{
            let type = dataSource[pickerView.selectedRow(inComponent: 0)].englishValue
            let temp = leftTextField.text ?? "0.0"
            return  ["unit": type, "value": Float(temp) ?? 0.0]
        }
        return [:]
    }
    
}
