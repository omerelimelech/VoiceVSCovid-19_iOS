//
//  RadioButtonsSelectionView.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 01/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation
import UIKit

class RadioButton: UIButton {



    override init(frame: CGRect) {
        super.init(frame: frame)
        initialConfig()
        
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialConfig()
    }
    
     func initialConfig() {
        self.cornerRadius = self.frame.height / 2
        self.borderColor = .mainBlue
        self.layerBorderWidth = 1
        self.setTitle(nil, for: .normal)

    }
    
    public func select(){
        self.backgroundColor = isSelected ? .purpleBlue : .white
    }
    
    
    
}



extension UIColor {
    
    class var neonGreen: UIColor {
        return UIColor.hexStringToUIColor(hex: "9AFFF9")
    }
    
    class var lightBlue: UIColor {
        return UIColor.hexStringToUIColor(hex: "34CDFD")
    }
    
    class var mainBlue: UIColor {
        return UIColor.hexStringToUIColor(hex: "016BFE")
    }
    
    class var purpleBlue: UIColor {
        return UIColor.hexStringToUIColor(hex: "5A88FF")
    }
    
    class var darkBlue: UIColor {
           return UIColor.hexStringToUIColor(hex: "12218D")
    }
    
    class var softenBlue: UIColor{
        return UIColor.hexStringToUIColor(hex: "0E6CFB")
    }

    class var darkPurple: UIColor {
           return UIColor.hexStringToUIColor(hex: "5928E4")
    }
    class var disabledGray: UIColor {
        return UIColor.hexStringToUIColor(hex: "C4C4C4")
    }
    
    class var labelBlack: UIColor {
        return UIColor.hexStringToUIColor(hex: "333333")
    }
    
}
