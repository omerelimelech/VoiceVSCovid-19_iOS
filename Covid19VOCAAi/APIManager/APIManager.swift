//
//  APIManager.swift
//  QuestionSomething
//
//  Created by Omer Elimelech on 21/12/2019.
//  Copyright © 2019 Omer Elimelech. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD

//typealias completion = (_ result: Result<Any?>) -> Void
typealias completion = (_ result: Result<Any?, Error>) -> Void
typealias parameters = [String : Any]

struct ParameterKey{
    static var deviceId = "device_id"
}

enum MyErrors : Error{
    case noResults
    case parseError
    case decodeError
    
}


class APIManager : NSObject {
    
    static let shared = APIManager()
   
    // MARK: - VOCA FUNCTIONS
    private let Alamofire = AF
    func sendReport(params: [String: Any], completion: @escaping completion){
        let url = UrlManager.shared.url(endpoint: .submissions)
        print (url)
        self.baseRequest(withUrlString: url, method: .post, params: params, completion: completion)
        
    }
    
    func submitRecord(submitId: String, recordName: String, completion: @escaping completion){
        let url = UrlManager.shared.url(endpoint: .record(submitId, recordName))
        print (url)
        let json = ["fileType": "audio/wav"]
        self.baseRequest(withUrlString: url, method: .post, params: json, completion: completion)
    }
    
    func submitFeedback(submitId: String){
        let url = UrlManager.shared.url(endpoint: .feedback(submitId))
        self.baseRequest(withUrlString: url, method: .post) { (result) in
            print (result)
        }
    }
    
    func uploadS3(to url: String, fileURL: URL, withName name: String, completion: @escaping completion){
        
        AF.upload(fileURL, to: URL(string: url)!).response { (response) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    
    //MARK: - MOD FUNCTIONS
    
    //MARK: - USER
    func getUser(completion: @escaping completion){
        let url = UrlManager.shared.url(base: .MODBaseUrl, endpoint: .me)
        AF.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func postUserInfo(method: HTTPMethod = .post, params: Parameters?, completion: @escaping completion){
        let url = UrlManager.shared.url(base: .MODBaseUrl, endpoint: .userInfo)
        let headers = HTTPHeaders([:])
        AF.request(url, method: method, parameters: params, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
    
    //MARK: - AUTHENTICATION
    
    func signUp(method: HTTPMethod = .post, params: Parameters?, completion: @escaping completion){
       let url = UrlManager.shared.url(base: .MODBaseUrl, endpoint: .signUp)
       let headers = HTTPHeaders([:])
       AF.request(url, method: method, parameters: params, headers: headers).responseJSON { (response) in
       switch response.result {
           case .success(let data):
               completion(.success(data))
           case .failure(let error):
               completion(.failure(error))
           }
       }
   }
    
    func login(method: HTTPMethod = .post, params: Parameters?, completion: @escaping completion){
        let url = UrlManager.shared.url(base: .MODBaseUrl, endpoint: .login)
        let headers = HTTPHeaders([:])
        AF.request(url, method: method, parameters: params, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func refreshToken(method: HTTPMethod = .get, params: Parameters?, completion: @escaping completion){
        let url = UrlManager.shared.url(base: .MODBaseUrl, endpoint: .refreshToken)
        let headers = HTTPHeaders([:])
        AF.request(url, method: method, parameters: params, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - APP LOGIC
    func getQuestions(method: HTTPMethod = .get, params: Parameters?, completion: @escaping completion){
        let url = UrlManager.shared.url(base: .MODBaseUrl, endpoint: .questions)
        let headers = HTTPHeaders([:])
        self.baseRequest(withUrlString: url, method: .get, completion: completion)
    }
    
    func getQuestionById(id: String, method: HTTPMethod = .get, params: Parameters?, completion: @escaping completion){
        let url = UrlManager.shared.url(base: .MODBaseUrl, endpoint: .question(id))
        let headers = HTTPHeaders([:])
        AF.request(url, method: method, parameters: params, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
    
    func sendQuestionResponse(method: HTTPMethod = .get, params: Parameters?, completion: @escaping completion){
        let url = UrlManager.shared.url(base: .MODBaseUrl, endpoint: .questionResponse)
        let headers = HTTPHeaders([:])
        AF.request(url, method: method, parameters: params, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - PPG
    func sendPPGData(method: HTTPMethod = .post, params: Parameters?, completion: @escaping completion){
        let url = UrlManager.shared.url(base: .MODBaseUrl, endpoint: .ppgMeasurment)
        let headers = HTTPHeaders(["Authorization": "JWT \(UserModel.shared.token?.access ?? "")"])
        self.baseRequest(withUrlString: url, method: .post, params: params, headers: headers, completion: completion)
    }
    
    func sendMeasurment(method: HTTPMethod = .post, params: Parameters?, completion: @escaping completion){
        let url = UrlManager.shared.url(base: .MODBaseUrl, endpoint: .measurment)
        let headers = HTTPHeaders(["Authorization": "JWT \(UserModel.shared.token?.access ?? "")"])
        AF.request(url, method: method, parameters: params, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
    
    
}

//MARK: Base requests
extension APIManager {
    
    func request(withUrlString urlString: String, method: HTTPMethod, params: Parameters? = nil, headers: HTTPHeaders? = ["Content-Type":"application/json", ], completion: @escaping completion){
        guard let url = URL(string: urlString) else {return}
        Alamofire.request(url, method: method, parameters: params, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let json = value as? [String: Any] else {completion(.failure(MyErrors.parseError)); return}
                completion(.success(json))
            case .failure(let error):
                completion(.failure(error))
            }

        }
    }

    func baseRequest(withUrlString urlString: String, method: HTTPMethod, params: Parameters? = nil, headers: HTTPHeaders? = ["Content-Type": "application/json", "Authorization": "JWT \(UserModel.shared.token?.access ?? "")"], completion: @escaping completion){
        guard let url = URL(string: urlString) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("JWT \(UserModel.shared.token?.access ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            if let params = params{
                request.httpBody   = try JSONSerialization.data(withJSONObject: params)
            }
        } catch let error {
            print("Error : \(error.localizedDescription)")
        }

        Alamofire.request(request).responseJSON { (response) in
            switch response.result{
            case .success(let json):
                completion(.success(json))
            case .failure(let error):
                completion(.failure(error))
            }
        }
                
    }
}

struct JSONStringArrayEncoding: ParameterEncoding {
    private let jsonArray: [[String: String]]

    init(jsonArray: [[String: String]]) {
        self.jsonArray = jsonArray
    }

    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()

        let data = try JSONSerialization.data(withJSONObject: jsonArray, options: [])

        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        urlRequest.httpBody = data

        return urlRequest
    }
}
