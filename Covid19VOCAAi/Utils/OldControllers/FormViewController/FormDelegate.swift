//
//  FormDelegate.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 07/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation


protocol FormDelegate: class {
    func formPresenter(_ presenter: FormPresenter, didPostSubmission submission: Submission)
    func formPresenter(_ presenter: FormPresenter, didFailPostSubmissionWith error: Error)
}


extension String {
    public func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
}

extension String{
    func englishLocalized() -> String{
        let language = "Base"
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        guard let bundle = Bundle(path: path!) else {return ""}
        return bundle.localizedString(forKey: self, value: nil, table: nil)
    }
}
