//
//  BaseView.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 05/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation
import UIKit


class BaseView: UIView {
    
    weak var nibView: UIView!
    
    
    func initialConfig() {
         let nibName = NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
         let nib = loadNib(nibName)
         nib.frame = bounds
         nib.translatesAutoresizingMaskIntoConstraints = true
         addSubview(nib)
         nib.backgroundColor = .clear
         nibView = nib
     }
}


extension UIView {
    func loadNib(_ name: String) -> UIView {
         let bundle = Bundle(for: type(of: self))
         let nib = UINib(nibName: name, bundle: bundle)
         let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
         
         return view
     }
     
}
