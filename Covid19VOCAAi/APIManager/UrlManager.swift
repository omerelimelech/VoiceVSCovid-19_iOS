//
//  UrlManager.swift
//  QuestionSomething
//
//  Created by Omer Elimelech on 21/12/2019.
//  Copyright © 2019 Omer Elimelech. All rights reserved.
//

import Foundation


struct UrlManager {
    
    static let shared = UrlManager()
    
    var baseUrl = Constants.baseUrl
    
    enum Endpoint {
            typealias RawValue = String
            case submissions
            case record(String, String)
            case feedback(String)
            var rawValue: String {
               switch self {
               case .submissions:
                return "/submissions"
               case .record(let id, let name):
                return String(format: "/submissions/%@/recordings/%@", id, name)
               case .feedback(let id):
                return String(format: "/submissions/%@/feedback", id)
                
                
            }
                
           }
        
            private func fotmattedString(string: String, withParam param: String) -> String{
                return String(format: string, param)
        }
       }
       func url(endpoint: Endpoint) -> String{
           return "\(baseUrl)\(endpoint.rawValue)"
       }
    
    
    
    
   
   }
