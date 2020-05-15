//
//  StringHelper.swift
//  Covid19VOCAAi
//
//  Created by Yevhenii on 09.05.2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation

public class StringHelper: NSObject
{
    public static func stringForClass(_ aClass : AnyClass) -> String {
        return String(describing: aClass.self)
    }
    
    public static func classNameForObject(_ obj: Any) -> String
    {
        let result = String(describing: type(of: obj))
        return result
    }
}

