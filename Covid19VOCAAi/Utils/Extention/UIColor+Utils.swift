//
//  UIColor+AppColor.swift
//  Trade
//
//  Created by Omer Elimelech on 9/15/16.
//  Copyright © 2016 Omer Elimelech. All rights reserved.
//

import UIKit

//Legacy
extension UIColor {
    
    static func createColor(red: Int, green: Int, blue:Int, alpha: Float) -> UIColor {
        return UIColor.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(alpha))
    }
    
    class var blueButtonColor : UIColor {
        return UIColor.createColor(red: 66, green: 161, blue: 221, alpha: 1)
    }
    
    class var grayButtonColor : UIColor {
        return UIColor.createColor(red:60, green: 79, blue: 98, alpha: 0.06)
    }
    
    class var navigationColor : UIColor {
        return UIColor.createColor(red: 255, green: 255, blue: 255, alpha: 1)
    }
    
    class var backgroundColor : UIColor {
        return UIColor.createColor(red: 240, green: 243, blue: 245, alpha: 1)
    }
    
    class var appRedColor: UIColor {
        return UIColor.createColor(red: 199, green: 43, blue: 50, alpha: 1)
    }
    
    class var tabNormalColor: UIColor {
        return UIColor.createColor(red: 99, green: 114, blue: 130, alpha: 1)
    }
    
    class var tabSelectedColor: UIColor {
        return UIColor.createColor(red: 66, green: 161, blue: 221, alpha: 1)
    }
    
    class var capacityGradientColors: [CGColor] {
        return [UIColor.createColor(red: 255, green: 68, blue: 59, alpha: 1).cgColor, UIColor.createColor(red: 255, green: 194, blue: 74, alpha: 1).cgColor, UIColor.createColor(red: 60, green: 215, blue: 89, alpha: 1).cgColor]
    }
    
    class var gameActionDoneColor: UIColor {
        return UIColor.createColor(red: 22, green: 181, blue: 69, alpha: 1)
    }
    
    class var gameActionFailedColor: UIColor {
        return UIColor.createColor(red: 240, green: 55, blue: 68, alpha: 1)
    }
    
    class var gameActionNotAvailableColor: UIColor {
        return UIColor.createColor(red: 99, green: 114, blue: 130, alpha: 1)
    }
}

//NEW
extension UIColor {
    
    class var textField: UIColor {
        return UIColor.init(red: 241.0/255.0, green: 242.0/255.0, blue: 243.0/255.0, alpha: 1.0)
    }

    class var textFieldText: UIColor {
        return UIColor.init(red: 60.0/255.0, green: 79.0/255.0, blue: 98.0/255.0, alpha: 1.0)
    }

    class var textFieldTitle: UIColor {
        return UIColor.init(red: 150.0/255.0, green: 161.0/255.0, blue: 170.0/255.0, alpha: 1.0)
    }

    class var textFieldBorder: UIColor {
        return UIColor.createColor(red: 244, green: 245, blue: 246, alpha: 1)
    }

    class var disabledTabTitle: UIColor {
        return UIColor.createColor(red: 157, green: 167, blue: 176, alpha: 1)
    }

    class var activeTabTitle: UIColor {
        return UIColor.createColor(red: 8, green: 147, blue: 162, alpha: 1)
    }
    
    class var progessCompleted: UIColor {
        return UIColor.createColor(red: 8, green: 147, blue: 162, alpha: 1)
    }

    class var tipView: UIColor {
        return UIColor.createColor(red: 116, green: 110, blue: 202, alpha: 1)
    }
    
    class var progessIncomplete: UIColor {
        return UIColor.createColor(red: 218, green: 218, blue: 221, alpha: 1)
    }
    
    class var appBlue: UIColor {
        return UIColor.createColor(red: 8, green: 147, blue: 162, alpha: 1)
    }

    class var orderStatusBackground: UIColor {
        return UIColor.createColor(red: 8, green: 147, blue: 162, alpha: 0.05)
    }
    
    class var tipBackground: UIColor {
        return UIColor.createColor(red: 116, green: 110, blue: 202, alpha: 1)
    }

    class var initialConsultation: UIColor {
        return UIColor.createColor(red: 249, green: 123, blue: 81, alpha: 1)
    }

    class var followUpConsultation: UIColor {
        return UIColor.createColor(red: 149, green: 160, blue: 170, alpha: 1)
    }

    class var appGray: UIColor {
        return UIColor.createColor(red: 157, green: 167, blue: 176, alpha: 1)
    }

    class var separatorGray: UIColor {
        return UIColor.createColor(red: 235, green: 235, blue: 235, alpha: 1)
    }

    class var phoneSeparator: UIColor {
        return UIColor.createColor(red: 219, green: 219, blue: 219, alpha: 1)
    }
    
    class var buttonBlue: UIColor {
        return UIColor.createColor(red: 8, green: 147, blue: 162, alpha: 1)
    }
    
    class var buttonGray: UIColor {
        return UIColor.createColor(red: 219, green: 219, blue: 219, alpha: 1)
    }
    
    class var buttonRed: UIColor {
        return UIColor.createColor(red: 236, green: 16, blue: 42, alpha: 1)
    }

    class var orderStatusCompleted: UIColor {
        return UIColor.createColor(red: 236, green: 247, blue: 248, alpha: 1)
    }

    class var orderStatusMissed: UIColor {
        return UIColor.createColor(red: 252, green: 235, blue: 237, alpha: 1)
    }

    class var orderStatusUpcoming: UIColor {
        return UIColor.createColor(red: 254, green: 243, blue: 240, alpha: 1)
    }

    class var orderStatusIncomplete: UIColor {
        return UIColor.createColor(red: 240, green: 241, blue: 243, alpha: 1)
    }

    class var orderStatusSubmited: UIColor {
        return UIColor.createColor(red: 254, green: 248, blue: 240, alpha: 1)
    }

    class var orderStatusCompletedText: UIColor {
        return UIColor.createColor(red: 8, green: 147, blue: 162, alpha: 1)
    }

    class var orderStatusMissedText: UIColor {
        return UIColor.createColor(red: 208, green: 2, blue: 27, alpha: 1)
    }

    class var orderStatusUpcomingText: UIColor {
        return UIColor.createColor(red: 234, green: 101, blue: 57, alpha: 1)
    }

    class var orderStatusIncompleteText: UIColor {
        return UIColor.createColor(red: 150, green: 160, blue: 170, alpha: 1)
    }

    class var orderStatusSubmitedText: UIColor {
        return UIColor.createColor(red: 234, green: 165, blue: 57, alpha: 1)
    }

    class var notificationRed: UIColor {
        return UIColor.createColor(red: 251, green: 31, blue: 57, alpha: 1)
    }

    class var notificationGreen: UIColor {
        return UIColor.createColor(red: 60, green: 235, blue: 56, alpha: 1)
    }
    
    class var orderGridGray: UIColor {
        return UIColor.createColor(red: 157, green: 167, blue: 176, alpha: 1)
    }
    
    class var earningCellYearNormal: UIColor {
        return UIColor.createColor(red: 157, green: 167, blue: 176, alpha: 1)
    }
    
    class var earningCellYearSelected: UIColor {
        return UIColor.createColor(red: 60, green: 79, blue: 98, alpha: 1)
    }
    
    class var earningCellMonthLabelNormal: UIColor {
        return UIColor.createColor(red: 39, green: 61, blue: 82, alpha: 1)
    }
    
    class var earningCellMonthBackgroundNormal: UIColor {
        return UIColor.createColor(red: 246, green: 248, blue: 249, alpha: 1)
    }
    
    class var earningCellMonthBackgroundSelected: UIColor {
        return UIColor.createColor(red: 8, green: 147, blue: 162, alpha: 1)
    }

    class var disabledTextField: UIColor {
        return UIColor.createColor(red: 198, green: 201, blue: 204, alpha: 1)
    }
    
    class var symptomCodeBgColor: UIColor {
        return UIColor.createColor(red: 101, green: 175, blue: 231, alpha: 1)
    }
    
    class var orderCodeBgColor: UIColor {
        return UIColor.createColor(red: 175, green: 183, blue: 191, alpha: 1)
    }
    
    class var appWhite: UIColor {
        return UIColor.createColor(red: 243, green: 244, blue: 245, alpha: 1)
    }

    class var appointmentTitle: UIColor {
        return UIColor.createColor(red: 135, green: 144, blue: 153, alpha: 1)
    }

    class var appointmentText: UIColor {
        return UIColor.createColor(red: 60, green: 79, blue: 98, alpha: 1)
    }

    class var appointmentTitleScheduled: UIColor {
        return UIColor.createColor(red: 255, green: 136, blue: 96, alpha: 1)
    }

    class var appointmentTextScheduled: UIColor {
        return UIColor.createColor(red: 231, green: 94, blue: 20, alpha: 1)
    }

    class var warningRed: UIColor {
        return UIColor.createColor(red: 208, green: 2, blue: 27, alpha: 1)
    }
    
    class var appointmentCellDisableColor: UIColor {
        return UIColor.createColor(red: 192, green: 191, blue: 191, alpha: 1)
    }
}


extension UIColor {

    class var initialGraph: UIColor {
        return UIColor.createColor(red: 8, green: 147, blue: 162, alpha: 100)
    }

    class var followUpGraph: UIColor {
        return UIColor.createColor(red: 63, green: 228, blue: 40, alpha: 100)
    }
    
    static func hexStringToUIColor(hex:String, alpha: CGFloat? = nil) -> UIColor {
        
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count != 6 {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0


        
        Scanner(string: cString).scanHexInt32(&rgbValue)

        if let _alpha = alpha {
            return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(_alpha)
            )
        } else {
            return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
        }
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format:"#%06x", rgb)
    }
}
