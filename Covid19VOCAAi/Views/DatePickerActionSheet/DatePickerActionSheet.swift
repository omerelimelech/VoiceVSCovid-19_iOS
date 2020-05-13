//
//  DatePickerActionSheet.swift
//  Covid19VOCAAi
//
//  Created by Yevhenii on 13.05.2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

class DatePickerActionSheet: UIAlertController {
    
    private let alertActionHeight: CGFloat = 58
    private let cancelActionVerticalPadding: CGFloat = 8
    
    private lazy var pickerView: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        return picker
    }()
    
    private var dateString: String = ""
    
    var dateStringHandler: ((_ date: String) -> Void)?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
    
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateString = formatter.string(from: pickerView.date)
        /*
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = components.day, let month = components.month, let year = components.year {
            dateString = "\(day) \(month) \(year)"
        }
        */
    }
}

private extension DatePickerActionSheet {
    
    func initUI() {
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { [weak self] (_) in
            guard let self = self else { return }
            self.dateStringHandler?(self.dateString)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        addAction(confirmAction)
        addAction(cancelAction)
        self.view.addSubview(pickerView)
        
        layout()
    }
    
    func layout() {
        
        let bottomPadding = (CGFloat(actions.count) * alertActionHeight) + (cancelActionVerticalPadding * 2)
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            pickerView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            pickerView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            pickerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -bottomPadding)
        ])
    }
}
