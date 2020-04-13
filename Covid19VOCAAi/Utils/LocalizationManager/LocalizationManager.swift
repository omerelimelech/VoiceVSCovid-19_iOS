//
//  LocalizationManager.swift
//  Trade
//
//  Created by Omer Elimelech on 11/17/16.
//  Copyright © 2016 Omer Elimelech. All rights reserved.
//

import Foundation


protocol LocalizationTranslator {

    func translation(forKey key: String) -> String
    func translation(forKey key: String, defValue: String?) -> String
    
}

extension LocalizationManager {
    
    static func localize(_ key: String, defValue: String? = nil ) -> String {
        return LocalizationManager.sharedManager.localizedString(key)
    }
    
    func localizedString(_ key: String) -> String {
        let languageName = UserSettings.sharedSettings.getSelectedLocalization()
        let locale = Locale.locale(forLaguageName: languageName)
        let translator = LocalizationManager.sharedManager.translator(forLocale: locale)
        return translator.translation(forKey: key)
    }
    
}

extension LocalizationManager {
    
    func localize(_ date: Date, formatter: DateFormatter) -> String {
        let prevLocale = formatter.locale
        formatter.locale = UserSettings.sharedSettings.getSelectedLocale() as Locale?
        
        let localizedDate = formatter.string(from: date)
        formatter.locale = prevLocale
        
        return localizedDate
    }
    
    static func localize(_ date: Date, formatter: DateFormatter) -> String {
        return LM.sharedManager.localize(date, formatter: formatter)
    }
    
}

typealias LM = LocalizationManager

final class LocalizationManager {
    
    static let sharedManager = LocalizationManager()
    
    fileprivate var currentLocale: Locale?
    fileprivate var localeToTranslatorMap = [Locale : LocalizationTranslator]()
    
    var defaultTranslator: LocalizationTranslator {
        let localeCode = Locale.preferredLanguages.first!
        let locale = Locale.init(identifier: localeCode)
        
        return self.translator(forLocale: locale)
    }
    
    func translator(forLocale locale: Locale) -> LocalizationTranslator {
        let translator = self.resolveTranslator(forLocale:locale);
        return translator;
    }
    
}



private extension LocalizationManager {
    
    func resolveTranslator(forLocale locale: Locale) -> LocalizationTranslator {
        var translator = self.localeToTranslatorMap[locale];
        if (translator == nil) {
            let bundle = self.bundle(forLocale: locale)
            translator = LocalizationInternalTranslator.init(withBundle: bundle, andTranslationTable: nil)
            self.localeToTranslatorMap[locale] = translator;
        }
        
        return translator!
    }
    
    func bundle(forLocale locale: Locale) -> Bundle {
        let localeIdentifier = locale.identifier;
        
        var path = self.mainBundle.path(forResource: localeIdentifier, ofType: "lproj")
        var localeBundle = path != nil ? Bundle.init(path: path!) : nil
        if localeBundle == nil {
            path = self.mainBundle.path(forResource: locale.localeLanguageCode, ofType: "lproj")
            localeBundle = path != nil ? Bundle.init(path: path!) : nil
        }
        
        if localeBundle == nil {
            path = self.mainBundle.path(forResource: "Base", ofType: "lproj")
            localeBundle = path != nil ? Bundle.init(path: path!) : nil
        }
        
        if localeBundle == nil {
            localeBundle = self.mainBundle
        }
        
        return localeBundle!
    }
    
    var mainBundle: Bundle {
        return Bundle.main
    }
    
}

final private class LocalizationInternalTranslator {
    
    let bundle: Bundle
    let translationTable: String?
    
    init(withBundle bundle: Bundle, andTranslationTable translationTable: String?) {
        self.bundle = bundle
        self.translationTable = translationTable
    }
    
}

extension LocalizationInternalTranslator: LocalizationTranslator {
    
    func translation(forKey key: String) -> String {
        return self.translation(forKey: key, defValue: nil)
    }
    
    func translation(forKey key: String, defValue: String? = nil) -> String {
        let translation = self.bundle.localizedString(forKey: key, value: defValue, table: self.translationTable)
        return translation
    }

}

extension String {
    
    var lm_localised : String {
        get {
            return LocalizationManager.localize(self)
        }
    }
    
}

