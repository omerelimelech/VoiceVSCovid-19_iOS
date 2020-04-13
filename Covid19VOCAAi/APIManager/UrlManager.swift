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
            case categories
            case difficulties
            case questions
            case likes(String)
            case dislikes(String)
        
            var rawValue: String {
               switch self {
               case .categories:
                return "api/categories"
               case .difficulties:
                return "api/difficulties"
               case .questions:
                return "api/questions"
               case .dislikes(let s):
                  return fotmattedString(string: "api/questions/%@/dislikes", withParam: s)
               case .likes(let s):
                return fotmattedString(string: "api/questions/%@/likes", withParam: s)
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
