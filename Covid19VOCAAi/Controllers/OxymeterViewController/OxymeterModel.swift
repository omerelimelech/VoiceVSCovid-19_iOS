//
//  OxymeterModel.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 02/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation



class OxymeterModel {
    
    
    func sendPPGData(red: [Double], blue: [Double], green: [Double], timePoint: [Int],measureId: Int, completion: @escaping completion) {
        APIManager.shared.sendPPGData(params: ["red": red, "blue": blue, "green": green, "timepoint": timePoint, "measurement": measureId], completion: completion)
    }
}
