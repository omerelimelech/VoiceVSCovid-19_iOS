//
//  languageCode.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 14/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation


func languageCode() -> String? {
    return NSLocale.autoupdatingCurrent.languageCode
}

public enum LanguageType: String {
    case eng = "en"
    case heb = "he"
    case other = ""
    
    static var current: LanguageType {
        guard let lang = languageCode() else { return .other }
        return LanguageType.init(rawValue: lang) ?? .other
    }
}

func isRTL() -> Bool {
    return LanguageType.current == .heb
}
