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

typealias completion = (_ result: Result<Any?>) -> Void
typealias parameters = [String : Any]

struct ParameterKey{
    static var deviceId = "device_id"
}
class APIManager : NSObject {
    
    static let shared = APIManager()
   
    func getCategories(completion: @escaping completion){
        let url = UrlManager.shared.url(endpoint: .categories)
        print (url)
        self.request(withUrlString: url, method: .get, completion: completion)
        
    }
    
    func getDifficulties(completion: @escaping completion){
        let url = UrlManager.shared.url(endpoint: .difficulties)
        print (url)
        self.request(withUrlString: url, method: .get, completion: completion)
    }
    
    func getQuestions(completion: @escaping completion){
        let url = UrlManager.shared.url(endpoint: .questions)
        print (url)
        self.request(withUrlString: url, method: .get, completion: completion)
    }
    
    func setLike(questionId : String, params: parameters, completion: @escaping completion){
        let url = UrlManager.shared.url(endpoint: .likes(questionId))
        self.baseRequest(withUrlString: url, method: .post, params: params, completion: completion)
    }
    
    func setDislike(questionId : String, params: parameters, completion: @escaping completion){
        let url = UrlManager.shared.url(endpoint: .dislikes(questionId))
        self.baseRequest(withUrlString: url, method: .post, params: params ,completion: completion)
    }
    
    
}

//MARK: Base requests
extension APIManager {
    
    func request(withUrlString urlString: String, method: HTTPMethod, params: Parameters? = nil, headers: HTTPHeaders? = nil, completion: @escaping completion){
        guard let url = URL(string: urlString) else {return}
        Alamofire.request(url, method: method, parameters: params, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let json = value as? [String: Any] else {completion(.failure(myErrors.parseError)); return}
                completion(.success(json))
            case .failure(let error):
                completion(.failure(error))
            }
           
        }
    }

    func baseRequest(withUrlString urlString: String, method: HTTPMethod, params: Parameters? = nil, headers: HTTPHeaders? = ["Content-Type": "application/json"], completion: @escaping completion){
        guard let url = URL(string: urlString) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            if let params = params{
                request.httpBody   = try JSONSerialization.data(withJSONObject: params)
            }
        } catch let error {
            print("Error : \(error.localizedDescription)")
        }
        Alamofire.request(request).response{ (response) in
            switch response.response?.statusCode {
                case 200:
                    completion(.success(nil))
                default:
                   completion(.failure(MyErrors.noResults))
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
