//
//  MainRequest.swift
//  Hackthon
//
//  Created by Alsharif Abdullah on 02/08/2018.
//  Copyright © 2018 Alsharif Abdullah. All rights reserved.
//

import Foundation
import Alamofire



class Request {
    
    static let system = Request()
    typealias JSONDictionary = [String: Any]
    typealias QueryResult = (Any) -> ()

    func request(url: String ,method: HTTPMethod, params: Parameters?, headers: HTTPHeaders?, completion: @escaping QueryResult) {
        let url: URL = URL(string: url)!
        Alamofire.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                
                switch(response.result) {
                case .success(_):
                    if response.result.value != nil{
                        let dict = response.result.value
                        completion(dict)
                    }
                    break
                    
                case .failure(_):
                    print(response.response?.statusCode, response)
                    break
                    
                }
        }
    }
}
