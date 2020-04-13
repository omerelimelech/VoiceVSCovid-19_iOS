//
//  RecordModel.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 07/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation

class RecordModel : NSObject {
    
    func sendRecord(recordName: String, completion: @escaping completion){
        APIManager.shared.submitRecord(submitId: GlobalData.shared.currentSubmissionId ?? "", recordName: recordName, completion: completion)
    }
    
    
}
