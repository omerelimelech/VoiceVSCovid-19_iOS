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

extension NSMutableAttributedString {
    var fontSize:CGFloat { return 14 }
    var boldFont:UIFont { return UIFont.openSansBold(size: fontSize) }
    var normalFont:UIFont { return UIFont.openSansRegular(size: fontSize)}

    func bold(_ value:String, size: CGFloat, color: UIColor = .labelBlack) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font : boldFont.withSize(size),
            .foregroundColor: color
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func normal(_ value:String, size: CGFloat, color: UIColor = .labelBlack) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font : normalFont.withSize(size),
            .foregroundColor : color
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    /* Other styling methods */
    func orangeHighlight(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.orange
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func blackHighlight(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.black

        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func underlined(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .underlineStyle : NSUnderlineStyle.single.rawValue

        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}
