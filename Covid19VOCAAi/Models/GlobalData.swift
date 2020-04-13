//
//  GlobalData.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 07/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation


class GlobalData : NSObject {
    
    private var defaults = UserDefaults.standard
    static let shared = GlobalData()
    
    var currentSubmissionId: String? {
        set{   defaults.set(newValue, forKey: "currentSubmissionId") }
        get{ defaults.value(forKey: "currentSubmissionId") as? String }
    }
    
    var agreedToTerms: Bool? {
        set{ defaults.set(newValue, forKey: "agreedToTerms") }
        get{ defaults.value(forKey: "agreedToTerms") as? Bool ?? false }
    }
    
}
