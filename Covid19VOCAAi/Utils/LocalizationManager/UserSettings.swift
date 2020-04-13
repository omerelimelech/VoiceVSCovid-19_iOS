//
//  UserSettings.swift
//  Trade
//
//  Created by Omer Elimelech on 10/25/16.
//  Copyright © 2016 Omer Elimelech. All rights reserved.
//

import Foundation

struct UserSettingChange<ValueType> {
    let oldValue: ValueType
    let newValue: ValueType
}

protocol UserSettingEventListener: class {
    func onLocalizationChanged(_ change: UserSettingChange<Locale>)
}

final class UserSettingBlockEventListener: UserSettingEventListener {
    
    var onLocalizationChangedBlock: ((_ change: UserSettingChange<Locale>) -> Void)?
    
    func onLocalizationChanged(_ change: UserSettingChange<Locale>) {
        self.onLocalizationChangedBlock?(change)
    }
    
}

// MARK: Notifications

extension UserSettings {
    
    @discardableResult func addEventListener(_ eventListener: UserSettingEventListener) -> EventSubscription {
        return self.eventBus.addEventListener(eventListener)
    }
    
    fileprivate func notifyEventListeners(_ notificationBlock: (UserSettingEventListener) -> Void) {
        self.eventBus.notifyListeners { (listener: UserSettingEventListener) in
            notificationBlock(listener)
        }
    }
    
}

// MARK: Helpers

extension UserSettings {
    
    func constructChange<T>(_ oldValue: T, newVlaue: T) -> UserSettingChange<T> {
        return UserSettingChange<T>.init(oldValue: oldValue, newValue: newVlaue)
    }
    
}

final class UserSettings {
    
    fileprivate let eventBus = EventBus()
    
    static let Localization = "Localization"
    
    static let sharedSettings = UserSettings()
    
    fileprivate let userDefaults = UserDefaults.standard
    
    func setup() {
        
        if self.getSelectedLocalization() == nil {
            self.setSelectedLocale(Locale.EnglishLocale)
        }
        
        if self.getSelectedLocalization() == nil || self.getSelectedLocalization()?.count == 0 {
            self.userDefaults.set("Russian", forKey: UserSettings.Localization)
        }
        
        self.userDefaults.synchronize()
    }
    
    func setSelectedLocalization(_ localization: String) {
        let locale = Locale.locale(forLaguageName: localization)
        self.setSelectedLocale(locale)
    }
    
    func getSelectedLocalization() -> String? {
        return self.getSelectedLocale().languageName
    }
    
    func setSelectedLocale(_ locale: Locale) {
        let oldValue = self.getSelectedLocale()
        
        self.userDefaults.set(locale.localeLanguageCode, forKey: UserSettings.Localization)
        self.userDefaults.synchronize()
        
        let change = self.constructChange(oldValue, newVlaue: locale)
        self.notifyEventListeners { (listener) in
            listener.onLocalizationChanged(change)
        }
    }
    
    func getSelectedLocale() -> Locale {
        let languageCode = self.userDefaults.object(forKey: UserSettings.Localization) as? String
        let locale = languageCode != nil ? Locale.init(identifier: languageCode!) : Locale.RussianLocale
        return locale
    }
    
}

extension UserSettings {
    
    func set(value: AnyObject, forKey key: String) {
        self.userDefaults.set(value, forKey: key)
        self.userDefaults.synchronize()
    }
    
    func value(forKey key: String) -> AnyObject? {
        return self.userDefaults.object(forKey: key) as AnyObject
    }
    
}
