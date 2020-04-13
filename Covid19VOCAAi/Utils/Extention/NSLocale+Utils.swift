//
//  NSLocale+Utils.swift
//  Trade
//
//  Created by Omer Elimelech on 11/17/16.
//  Copyright © 2016 Omer Elimelech. All rights reserved.
//

import Foundation

extension Locale {
    
    @nonobjc static let EnglishLocale: Locale = Locale.init(identifier: "en")
    @nonobjc static let RussianLocale: Locale = Locale.init(identifier: "ru")
    
    fileprivate static let _languageNameToLocaleMap = [
        "English" : Locale.EnglishLocale,
        "Russian" : Locale.RussianLocale,
    ]
    
    static func locale(forLaguageName rawName: String?) -> Locale {
        if rawName == nil {
            return Locale.current
        }
        
        let name = rawName!
        var locale = _languageNameToLocaleMap[name]
        if locale == nil {
            locale = Locale.current
        }
        
        return locale!
    }
    
    var languageName: String {
        for (languageName, locale) in Locale._languageNameToLocaleMap {
            if locale.localeLanguageCode == self.localeLanguageCode {
                return languageName
            }
        }
        
        return "English"
    }
    
    var localeLanguageCode: String {
        if #available(iOS 10.0, *) {
            return (self as NSLocale).languageCode
        } else {
            let components = Locale.components(fromIdentifier: self.identifier)
            return components[NSLocale.Key.languageCode.rawValue] ?? ""
        }
    }
    
    var longId: String {
        let result: String
        switch self.localeLanguageCode {
        case Locale.EnglishLocale.localeLanguageCode:
            result = "eng"
        case Locale.RussianLocale.localeLanguageCode:
            result = "rus"
        default:
            result = "rus"
        }
        
        return result
    }
    
}
