//
//  BasePresenter.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 05/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation
import UIKit


class BasePresenter : NSObject {
    func handleResult<T: Codable>(result: Result<Any?, Error>, type: T.Type ,group: DispatchGroup? = nil, completion: @escaping (_ result: T?) -> Void){
         switch result{
         case .success(let value):
             let data = try? JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
            guard let obj = try? decode(withObj: type.self, data: data!) else {handleError(error: MyErrors.decodeError, group: group); return}
                group?.leave()
                completion(obj)
         case .failure(let error):
             handleError(error: error, group: group)
         }
     }
    
    func handleResultWithoutResponse(result: Result<Any?, Error>) -> Error?{
        switch result {
        case .failure(let err):
            return err
        default:
            return nil
        }
    }
     
     
     func handleError(error: Error,group: DispatchGroup? = nil) -> Void {
        group?.leave()
        print(error.localizedDescription)
     }
}


func decode<T : Codable>(withObj obje: T.Type, data: Data) throws -> T?{
    
    let decoder = JSONDecoder()
    do {
        let obj = try decoder.decode(obje.self, from: data)
        return obj
    } catch {
        print(error.localizedDescription)
        throw error
    }
    
}
