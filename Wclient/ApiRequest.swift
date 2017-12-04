//
//  ApiRequest.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation
import Alamofire
import protocol Decodable.Decodable
import enum Decodable.DecodingError
import struct Decodable.KeyPath

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
        let apiVersion = "v1"
        return "https://www.wantedly.com/api/\(apiVersion)"
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
        return NSError(domain: "com.onefatgiraffe.Wclient",
                       code: 999,
                       userInfo: [NSLocalizedDescriptionKey: "A parsing error occured"])
    }
}
