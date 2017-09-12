//
//  ApiRequest.swift
//  Library
//
//  Created by Aaron Lee on 2017/09/02.
//  Copyright © 2017 One Fat Giraffe. All rights reserved.
//

import Foundation

protocol ApiRequest {
    var baseUrl: String { get }
    var path: String { get }
    var httpMethod: String { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
    var urlRequest: URLRequest { get }
    var responseKeyPath: [String] { get }
}

extension ApiRequest {
    var baseUrl: String {
        return "api.unsplash.com"
    }
    
    var path: String {
        return "/"
    }
    
    var httpMethod: String {
        return "GET"
    }
    
    var responseKeyPath: [String] {
        return []
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var urlRequest: URLRequest {
        let urlComponents = NSURLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseUrl
        urlComponents.path = path
        
        if let parameters = parameters, httpMethod == "GET" {
            urlComponents.queryItems = []
            for param in parameters.keys {
                urlComponents.queryItems!.append(URLQueryItem(name: param, value: "\(String(describing: parameters[param]!))"))
            }
        }
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = httpMethod
        request.httpBody = parameters?.toJsonData()
        
        if let headers = headers {
            for key: String in headers.keys {
                request.setValue(headers[key], forHTTPHeaderField: key)
            }
        }

        // Unsplash API
        request.setValue("Client-ID \(unsplashAppId)", forHTTPHeaderField: "Authorization")
        request.setValue("v1", forHTTPHeaderField: "Accept-Version")
        
        return request
    }
}
