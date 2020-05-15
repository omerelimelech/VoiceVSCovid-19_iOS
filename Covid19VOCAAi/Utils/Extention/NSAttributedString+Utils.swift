//
//  NSAttributedString+Utils.swift
//  Covid19VOCAAi
//
//  Created by Yevhenii on 15.05.2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    func appendString(_ string: String,
                      fontSize: CGFloat = 14,
                      weight: UIFont.Weight = .regular,
                      color: UIColor = .black,
                      underlined: Bool = false,
                      underlineColor: UIColor = .black,
                      preferredAttrs: [NSAttributedString.Key : Any] = [:]) {
        
        var defaultAttrs: [NSAttributedString.Key : Any] = [
            .font : UIFont.systemFont(ofSize: fontSize, weight: weight),
            .foregroundColor: color]
        
        if underlined {
            defaultAttrs[.underlineStyle] = NSUnderlineStyle.single.rawValue
            defaultAttrs[.underlineColor] = underlineColor
        }
        
        defaultAttrs = defaultAttrs.merge(right: preferredAttrs)
        
        self.append(NSAttributedString(string: string, attributes: defaultAttrs))
    }
}
