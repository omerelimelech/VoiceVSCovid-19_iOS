//
//  UIView+IBInspectable.swift
//  RadishApp
//
//  Created by Omer Elimelech on 7/10/18.
//  Copyright © 2018 BlazingBears. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    @IBInspectable open var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable open var layerBorderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    
    @IBInspectable open var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            } else {
                self.removeShadow()
            }
        }
    }
    
    @IBInspectable open var borderColor: UIColor? {
        get {
            return self.layer.borderColor != nil ? UIColor.init(cgColor: self.layer.borderColor!) : UIColor.clear
        }
        set {
            self.layer.borderColor = (newValue != nil) ? newValue!.cgColor : UIColor.clear.cgColor
        }
    }
    
    
    func addShadow(_ shadowColor: CGColor = UIColor.init(white: 0.8, alpha: 1.0).cgColor, shadowOffset: CGSize = CGSize(width: 0.5, height: 0.5), shadowOpacity: Float = 1.0, shadowRadius: CGFloat = 6.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = self.layer.cornerRadius > 0 ? self.layer.cornerRadius : shadowRadius
    }
    
    func removeShadow() {
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOffset = CGSize.zero
        layer.shadowOpacity = 0
        layer.shadowRadius = 0
    }
    
    func toolbarShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: -1)
        layer.shadowOpacity = 0.15
        layer.shadowRadius = 5
    }
}

extension UIView {
    
    func snapshotImage() -> UIImage {
        
        UIGraphicsBeginImageContext(self.frame.size)
        
        if let context = UIGraphicsGetCurrentContext() {
            
            self.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            return image!
        }
        
        return UIImage()
    }
    
}

extension UIView {
    
    func takeScreenshot() -> UIImage {
        
        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        
        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if (image != nil)
        {
            return image!
        }
        return UIImage()
    }
}

extension UIView {
    
    var currentScale: CGPoint {
        let a = transform.a
        let b = transform.b
        let c = transform.c
        let d = transform.d
        
        let sx = sqrt(a * a + b * b)
        let sy = sqrt(c * c + d * d)
        
        return CGPoint(x: sx, y: sy)
    }
    
    var currentRotate: CGFloat {
        
        let a = transform.a
        let b = transform.b
        
        return atan2(b, a)
    }
    
}

extension UIImageView {
    
    func frameForImageInImageViewAspectFit() -> CGRect {
        
        if let img = self.image {
            
            let imageRatio = img.size.width / img.size.height;
            
            let viewRatio = self.frame.size.width / self.frame.size.height;
            
            if (imageRatio < viewRatio) {
                
                let scale = self.frame.size.height / img.size.height;
                
                let width = scale * img.size.width;
                
                let topLeftX = (self.frame.size.width - width) * scale;
                
                return CGRect.init(x: topLeftX, y: 0, width: width, height: self.frame.size.height)
                
            } else {
                
                let scale = self.frame.size.width / img.size.width;
                
                let height = scale * img.size.height;
                
                let topLeftY = (self.frame.size.height - height) * scale;
                
                return CGRect.init(x: 0, y: topLeftY, width: self.frame.size.width, height: height)
            }
        }
        
        return CGRect.zero
    }
}


extension UIDatePicker {
    
    func set18YearValidation() {
        let currentDate: Date = Date()
        var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        var components: DateComponents = DateComponents()
        components.calendar = calendar
        components.year = -18
        let maxDate: Date = calendar.date(byAdding: components, to: currentDate)!
        components.year = -150
        let minDate: Date = calendar.date(byAdding: components, to: currentDate)!
        self.minimumDate = minDate
        self.maximumDate = maxDate
    }
}

extension UITextView {
    
    func addDoneButton(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.inputAccessoryView = toolBar//5
    }
}
