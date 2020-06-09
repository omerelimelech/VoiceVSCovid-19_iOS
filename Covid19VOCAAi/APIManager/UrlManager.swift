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
            case voiceRecording
            case feedback(String)
            case me
            case questions
            case question(String)
            case userInfo
            case questionResponse
            case signUp
            case login
            case refreshToken
            case ppgMeasurment
            case measurment
            var rawValue: String {
               switch self {
               case .submissions:
                return "/submissions"
               case .record(let id, let name):
                return String(format: "/submissions/%@/recordings/%@", id, name)
               case .feedback(let id):
                return String(format: "/submissions/%@/feedback", id)
               case .me:
                return "/api/me/"
               case .questions:
                return "/api/question/"
               case .question(let id):
                return String(format: "/api/question/%@/", id)
               case .userInfo:
                return "/api/user-info/"
               case .questionResponse:
                return "/question-response/"
               case .signUp:
                return "/api/me/sign-up/"
               case .login:
                return "/auth/login/phonenumber/"
               case .refreshToken:
                return "/auth/refresh/"
               case .ppgMeasurment:
                return "/api/ppg-measurement/"
               case .measurment:
                return "/api/measurement/"
               case .voiceRecording:
                return "/api/voice-recording"
            }
                
           }
        
            private func fotmattedString(string: String, withParam param: String) -> String{
                return String(format: string, param)
        }
       }
    func url(base: Constants.BaseUrls = .baseUrl, endpoint: Endpoint) -> String{
        return "\(base.rawValue)\(endpoint.rawValue)"
    }
    
    
    
    
   
   }
