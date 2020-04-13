//
//  S3Model.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 07/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation

struct S3Model: Codable{
    var bucket: String?
    var key: String?
    var presignedS3Url: String?
}
