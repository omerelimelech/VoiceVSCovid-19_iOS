//
//  TitlePickerView.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 05/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation
import UIKit


class TitlePickerView: BaseView {
    
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
    }
    
    
}

