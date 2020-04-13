//
//  UIFont+App.swift
//  
//
//  Created by Omer Elimelech on 3/22/18.
//  Copyright © 2018 Omer Elimelech. All rights reserved.
//

import UIKit

extension UIFont {
    
    static func appRegularFont(with size: CGFloat) -> UIFont {
        return UIFont.init(name: "CircularStd-Book", size: size)!
    }
    
    static func appLightFont(with size: CGFloat) -> UIFont {
        return UIFont.init(name: "CircularStd-Book", size: size)!
    }
    
    static func appMediumFont(with size: CGFloat) -> UIFont {
        return UIFont.init(name: "CircularStd-Medium", size: size)!
    }
    
    static func appBoldFont(with size: CGFloat) -> UIFont {
        return UIFont.init(name: "CircularStd-Bold", size: size)!
    }
}
