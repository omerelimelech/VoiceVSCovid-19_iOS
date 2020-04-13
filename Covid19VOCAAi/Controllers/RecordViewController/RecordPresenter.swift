//
//  RecordPresenter.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 07/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation


class RecordPresenter: BasePresenter {
    
    weak var delegate: RecordDelegate?
    
    var model = RecordModel()
    init(with delegate: RecordDelegate){
        self.delegate = delegate
    }
    
    func sendRecord(with recordName: String){
        self.model.sendRecord(recordName: recordName) { (result) in
            self.handleResult(result: result, type: S3Model.self) { (s3) in
                guard let s3 = s3 else {
                    //error
                    return
                }
                self.delegate?.recordPresenter(self, didPostRecordWith: s3)
            }
        }
    }
}
