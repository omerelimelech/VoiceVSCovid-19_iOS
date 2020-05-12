//
//  ThankYouForRecordDelegate.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 07/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation

protocol ThankYouForRecordDelegate : class {
    func thankYouForRecordPreseneter(_ presenter: ThankYouForRecordPresenter, didFailUploadRecordWith error: Error)
    func thankYouForRecordPreseneterDidUploadRecord(_ presenter: ThankYouForRecordPresenter)
}
