//
//  TitlePickerView.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 05/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation
import UIKit


class TitlePickerView: BaseView, UIPickerViewDelegate, UIPickerViewDataSource, ConfigureView{
  
    
    
    @IBOutlet weak var unitLabel: UILabel!
    
    
    @IBInspectable var unitText: String?{
        didSet{
            guard let unit = unitText else {return}
            self.unitLabel.text = unit
            self.unitLabel.isHidden = false
        }
    }
    var dataSource = [LocalizedEnum]()
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var pickerTextField: UITextField!
    var isPrimary = true
    
    let pickerView = UIPickerView()
    
    @IBInspectable var title: String? {
        didSet{
            self.titleLabel.text = title
        }
    }
    
    
    var onFillData: ( (_ text: String?) -> Void)?
    
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
        pickerTextField.delegate = self
        
    }
    var selectedString = ""
    @objc func selectItem(){
        self.pickerTextField.text = dataSource[pickerView.selectedRow(inComponent: 0)].localizedString()
        endEditing(true)
    }
    
    
    func configure(with title: String, dataSource: [LocalizedEnum]?, isPrimary: Bool){
        if let dataSource = dataSource {
            self.dataSource = dataSource
            setupPicker()
        }
        self.titleLabel.text = String(format: "%@ %@", title, isPrimary ? "*" : "")
    }
    
    func setupPicker() {
        pickerView.delegate = self
           pickerView.dataSource = self
           let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.width, height: 50))
           let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(selectItem))
           let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
           toolBar.setItems([space, space, button], animated: false)
           pickerTextField.inputView = pickerView
           pickerTextField.inputAccessoryView = toolBar
           pickerView.reloadAllComponents()
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row].localizedString()
    }
    
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
       }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
          return 1
      }
    
    public func getData() -> String{
        if pickerTextField.text != ""{
            return self.dataSource.count == 0 ? pickerTextField.text ?? "" : dataSource[pickerView.selectedRow(inComponent: 0)].englishValue
        }
        return ""
    }
    
    
}

extension TitlePickerView : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
         if textField.text != "", let fillData = onFillData {
               fillData(textField.text)
        }
    }
}
