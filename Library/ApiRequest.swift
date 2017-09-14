//
//  ApiRequest.swift
//  Library
//
//  Created by Aaron Lee on 2017/09/02.
//  Copyright © 2017 One Fat Giraffe. All rights reserved.
//

import Foundation
import Decodable
import Alamofire

protocol ApiRequest {
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
    static var responseKeyPath: [String] { get }
    associatedtype ResponseType
    static func parse(fromJson json: Any) -> Result<ResponseType>
}

extension ApiRequest {
    var baseUrl: String {
        return "https://api.unsplash.com"
    }
    
    var path: String {
        return "/"
    }
    
    var method: HTTPMethod {
        return HTTPMethod.get
    }
    
    static var responseKeyPath: [String] {
        return []
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    static func parse(fromJson json: Any) -> Result<ResponseType> {
        guard let value = json as? ResponseType else {
            return .failure(NSError.createParseError())
        }
        return .success(value)
    }
}

extension ApiRequest where ResponseType: Decodable {
    static func parse(fromJson json: Any) -> Result<ResponseType> {
        do {
            let value = try ResponseType.decode(json)
            return .success(value)
        } catch(let error) {
            return .failure(error)
        }
    }
}

extension NSError {
    static func createParseError() -> NSError {
        return NSError(domain: "com.onefatgiraffe.library",
                       code: 999,
                       userInfo: [NSLocalizedDescriptionKey: "A parsing error occured"])
    }
}
