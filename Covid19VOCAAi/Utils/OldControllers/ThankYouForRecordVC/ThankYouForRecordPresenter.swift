//
//  ThankYouForRecordPresenter.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 07/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation


class ThankYouForRecordPresenter: BasePresenter{
    
    
   weak var delegate: ThankYouForRecordDelegate?
    
    let model = ThankYouForRecordModel()
    
    init(with delegate: ThankYouForRecordDelegate){
        self.delegate = delegate
    }
    
    func updateRecord(bucket: S3Model, fileUrl: URL, name: String){
        model.sendRecord(toBucket: bucket, fileUrl: fileUrl, name: name) { (result) in
            if let error = self.handleResultWithoutResponse(result: result){
                self.delegate?.thankYouForRecordPreseneter(self, didFailUploadRecordWith: MyErrors.noResults)
            }else{
                self.delegate?.thankYouForRecordPreseneterDidUploadRecord(self)
            }
        }
    }
}
