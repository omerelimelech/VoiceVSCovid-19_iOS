//
//  SVProgressHud.swift
//  OnlineSchool
//
//  Created by Omer Elimelech on 3/14/18.
//  Copyright © 2018 Omer Elimelech. All rights reserved.
//

import Foundation
import SVProgressHUD

extension SVProgressHUD {
    
    static func hideOnMain() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    
    static func showOnMain(){
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    
}
