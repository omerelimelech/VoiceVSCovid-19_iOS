//
//  NSObject+Optional.swift
//  Trade
//
//  Created by Omer Elimelech on 9/16/16.
//  Copyright © 2016 Omer Elimelech. All rights reserved.
//

import Foundation

extension Optional {
    
    func realValue(_ realValueBlock: ((Wrapped) -> ())) {
        if let selfValue = self {
            realValueBlock(selfValue)
        }
    }
}


extension Optional {
    
    var isOptionalEmpty : Bool {
        switch self {
        case .none:
            return true
        case .some(let wrapped):
            guard let array = wrapped as? [Any] else {return true}
            return array.isEmpty
        }
    }
}
