//
//  RecordDelegate.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 07/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation


protocol RecordDelegate: class{
    func recordPresenter(_ presenter: RecordPresenter, didPostRecordWith bucket: S3Model)
    func recordPresenter(_ presenter: RecordPresenter, didFailPostRecordWith error: Error)
}
