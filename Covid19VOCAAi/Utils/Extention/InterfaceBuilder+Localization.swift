//
//  InterfaceBuilder+Localization.swift
//  
//
//  Created by Omer Elimelech on 8/26/19.
//  Copyright © 2019 Omer Elimelech. All rights reserved.
//

import Foundation

import UIKit

extension UIView {
    
    var localizationStorage: NSDictionary {
        get {
            var storage = objc_getAssociatedObject(self, "localizationStorage") as? NSDictionary
            if(storage == nil) {
                storage = NSDictionary()
                self.localizationStorage = storage!
            }
            
            return storage!
        }
        
        set(newValue) {
            objc_setAssociatedObject(self, "localizationStorage", newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func storeLocalizationText(text: String, withTag tag: String) {
        localizationStorage.setValue(text, forKey: tag)
    }
    
    func localizationText(withTag tag: String) -> String? {
        return localizationStorage.object(forKey: tag) as? String
    }
    
}

extension UILabel {
    
    @IBInspectable open var localizedText: String {
        set {
            let localizedText = newValue.lm_localised
            self.text = localizedText
            self.storeLocalizationText(text: newValue, withTag: "normal")
            
        }
        get {
            return self.localizationText(withTag: "normal") ?? ""
        }
    }
    
}

extension UITextField {
    
    @IBInspectable open var localizedText: String {
        set {
            let localizedText = newValue.lm_localised
            self.text = localizedText
            self.storeLocalizationText(text: newValue, withTag: "normal")
            
        }
        get {
            return self.localizationText(withTag: "normal") ?? ""
        }
    }
    
    @IBInspectable open var localizedPlaceholder: String {
        set {
            let localizedText = newValue.lm_localised
            self.placeholder = localizedText
            self.storeLocalizationText(text: newValue, withTag: "placeholder")
            
        }
        get {
            return self.localizationText(withTag: "placeholder") ?? ""
        }
    }
    
}

extension UIButton {
    
    func localizedTitleForState(state: UIControl.State) -> String {
        let state = "\(self.state)"
        return self.localizationText(withTag: state) ?? ""
    }
    
    func storeLocalizedTitleForState(text: String, state: UIControl.State) {
        let localizedText = text.lm_localised
        self.setTitle(localizedText, for: state)
        
        let state = "\(self.state)"
        self.storeLocalizationText(text: text, withTag: state)
    }
    
    @IBInspectable open var normalStateLocalizedTitle: String {
        set {
            self.storeLocalizedTitleForState(text: newValue, state: .normal)
        }
        get {
            return self.localizedTitleForState(state: state)
        }
    }
    
    @IBInspectable open var highlightedStateLocalizedTitle: String {
        set {
            self.storeLocalizedTitleForState(text: newValue, state: .highlighted)
        }
        get {
            return self.localizedTitleForState(state: .highlighted)
        }
    }
    
    @IBInspectable open var disabledStateLocalizedTitle: String {
        set {
            self.storeLocalizedTitleForState(text: newValue, state: .disabled)
        }
        get {
            return self.localizedTitleForState(state: .disabled)
        }
    }
    
    @IBInspectable open var selectedStateLocalizedTitle: String {
        set {
            self.storeLocalizedTitleForState(text: newValue, state: .selected)
        }
        get {
            return self.localizedTitleForState(state: .selected)
        }
    }
    
}

