//
//  ThankYouForRecordModel.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 07/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation


class ThankYouForRecordModel {
    
    func sendRecord(toBucket bucket: S3Model, fileUrl: URL, name: String, completion: @escaping completion){
        APIManager.shared.uploadS3(to: bucket.presignedS3Url ?? "", fileURL: fileUrl, withName: name, completion: completion)
    }
}
