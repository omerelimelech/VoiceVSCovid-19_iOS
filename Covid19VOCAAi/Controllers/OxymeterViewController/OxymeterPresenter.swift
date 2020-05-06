//
//  OxymeterPresenter.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 02/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation


struct IdResponse: Codable {
    var id: Int?
}
class OxymeterPresetner: BasePresenter {
    
    weak var delegate: OxymeterDelegate?
    
    var model =  OxymeterModel()
    init(delegate: OxymeterDelegate?){
        self.delegate = delegate
    }
    func sendPPGData(red: [Double], blue: [Double], green: [Double], timePoint: [Int], measureId: Int) {
        self.model.sendPPGData(red: red, blue: blue, green: green, timePoint: timePoint, measureId: measureId) { (result) in
            self.handleResult(result: result, type: IdResponse.self) { (obj) in
                self.delegate?.didReceiveMeasureId(id: obj?.id ?? 0)
            }
        }
    }
    
}
