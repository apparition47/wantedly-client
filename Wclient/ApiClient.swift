//
//  ApiRequest.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation
import Alamofire
import Decodable
import protocol Decodable.Decodable
import enum Decodable.DecodingError
import struct Decodable.KeyPath

protocol ApiClient {
    func execute<T: ApiRequest>(_ request: T, completion: @escaping (Result<T.ResponseType>) -> ())
}

protocol URLSessionProtocol {
	func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }

class ApiClientImplementation: ApiClient {

    private let sessionManager: Alamofire.SessionManager = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        return Alamofire.SessionManager(configuration:config)
    }()
    
	let urlSession: URLSessionProtocol
	
	init(urlSessionConfiguration: URLSessionConfiguration, completionHandlerQueue: OperationQueue) {
		urlSession = URLSession(configuration: urlSessionConfiguration, delegate: nil, delegateQueue: completionHandlerQueue)
	}
	
	init(urlSession: URLSessionProtocol) {
		self.urlSession = urlSession
	}
	
	// MARK: - ApiClient

    func execute<T: ApiRequest>(_ request: T, completion: @escaping (Result<T.ResponseType>) -> ()) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID \(unsplashAppId)"
        headers["Accept-Version"] = "v1"
        
        let urlString = request.baseUrl + request.path
        
        sessionManager
            .request(urlString, method: request.method, parameters: request.parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200...299)
            .responseJSON { response in
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                switch response.result {
                case .success(let json):
                    if T.responseKeyPath.count > 0 {
                        do {
                            let j = try json => KeyPath(T.responseKeyPath)
                            completion(T.parse(fromJson: j))
                        } catch(let error) {
                            completion(.failure(error))
                        }
                    } else {
                        completion(T.parse(fromJson: json))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }

}

struct DecodableArray<T: Decodable>: Decodable {
    typealias Element = T
    
    private(set) var array: [Element] = []
    
    init(_ array: [Element]) {
        self.array = array
    }
    
    static func decode(_ json: Any) throws -> DecodableArray<Element> {
        return DecodableArray(try [Element].decode(json))
    }
}
