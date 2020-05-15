//
//  GeneralFunctions.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 14/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation

func getDocumentsDirectory() -> URL {
      let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
      return paths[0]
  }
