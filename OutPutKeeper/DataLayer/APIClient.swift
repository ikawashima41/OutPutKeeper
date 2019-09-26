//
//  APIClient.swift
//  OutPutKeeper
//
//  Created by Iichiro Kawashima on 2019/09/01.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import Foundation
import Alamofire

enum Result<Value> {
    case success(Value)
    case error(Error)
}


enum RequestMethod {
    case GET
    case POST
    case PUT
    case DELETE

    var type: HTTPMethod {
        switch self {
        case .GET:
            return .get
        case .POST:
            return .post
        case .PUT:
            return .put
        case .DELETE:
            return .delete
        }
    }
}

final class APIClient {
    static let host = "https://maps.googleapis.com/maps/api/direction/json"

    static let shared = APIClient()
    private init() {}

    typealias Response = (Result<NSDictionary>) -> Void
    static func httpRequest(endpoint: String, method: RequestMethod, parameters: [String: Any], completion: @escaping (Response)) {
        AF.request(host + endpoint, method: method.type, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let result):
                    let json = result as! NSDictionary
                    completion(.success(json))
                case .failure(let error):
                    completion(.error(error))
                }
        }
    }
}
