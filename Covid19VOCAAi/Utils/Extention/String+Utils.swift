//
//  String+Utils.swift
//  Trade
//
//  Created by Omer Elimelech on 27.05.16.
//  Copyright © 2016 Omer Elimelech. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func removingWhitespaces() -> String {
         return components(separatedBy: .whitespaces).joined(separator: " ")
     }
    
    func trim() -> String{
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    func removeAllSpaces() -> String{
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    func stringWithUppercaseFirstLetter() -> String {
        return String(self.first!).capitalized + String(self.dropFirst())
    }

    var legacy: NSString {
        return self as NSString
    }
    
    static var version: String {
        return "\("version".lm_localised):\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "") \(Bundle.main.infoDictionary?["CFBundleVersion"] ?? "")"
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        
        return self.count > 0
        
//        let emailRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$"
//        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        return emailTest.evaluate(with: self)
    }
    
    func CGFloatValue() -> CGFloat? {
        guard let doubleValue = Double(self) else {
            return nil
        }
        
        return CGFloat(doubleValue)
    }

    func phoneNumberFromRequest() -> String {
        return self.replacingOccurrences(of: "+1", with: "")
    }
    
    func phoneNumberToRequest() -> String {

        if self.count == 0 {
            return ""
        } else {
            return "+1" + self.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "-", with: "")
        }
    }
}


extension String {
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height
    }
    
    func widthWithConstrainedHeight(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.width
    }
    
    func sizeForWidth(width: CGFloat, font: UIFont) -> CGSize {
        let attr = [NSAttributedString.Key.font: font]
        let height = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options:[.usesLineFragmentOrigin, .usesFontLeading], attributes: attr, context: nil).height
        return CGSize(width: width, height: ceil(height))
    }
    
    func height(for width : CGFloat, font : UIFont) -> CGFloat {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let attributedString = NSAttributedString(string: self, attributes: [NSAttributedString.Key.font: font])
        let range = CFRangeMake(0, attributedString.length)
        let framesetter = CTFramesetterCreateWithAttributedString(attributedString)
        let framesetterSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, range, nil, maxSize, nil)
        return framesetterSize.height
    }
    
    func deleteHTMLTag() -> String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}

extension NSAttributedString {
    
    func heightWithConstrainedWidth(width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func widthWithConstrainedHeight(height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
}


extension NSAttributedString {
    
    static func textWithLineSpacing(text: String, lineSpacing: CGFloat, alignment: NSTextAlignment = .center) -> NSAttributedString {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = .center
        
        let attrString = NSMutableAttributedString(string: text)
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        return attrString
    }
}
