//
//  OxymeterPresenter.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 02/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation


class OxymeterPresetner: BasePresenter {
    
    weak var delegate: OxymeterDelegate?
    
    var model =  OxymeterModel()
    init(delegate: OxymeterDelegate?){
        
        self.delegate = delegate
        
    }
    
}
