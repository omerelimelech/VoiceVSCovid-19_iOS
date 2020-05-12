//
//  Oxymeter.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 28/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation

protocol Oxymeter {
    func updateWithFrame(data: [UInt8]?, width: size_t, height: size_t, timePoint: Int)
    func finish(samplingFreq: Double) -> OxymeterData?
    func setOnInvalidData(_ completion : @escaping () -> Void)
    func setUpdateView(_ completion: @escaping (_ heartRate: Int) -> Void)
    func setUpdateGraphView(completion: @escaping (_ frame: Int, _ point: Double) -> Void)
    
}
