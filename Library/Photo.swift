//
//  Photo.swift
//  Library
//
//  Created by Aaron Lee on 2017/09/02.
//  Copyright © 2017 One Fat Giraffe. All rights reserved.
//

import Foundation
import Decodable

struct Photo {
    let id: String
    let createdAt: Date
    let updatedAt: Date
    let width: Int
    let height: Int
    let colour: String
    let likes: Int
    let description: String?
    let username: String
    let urls: PhotoUrl
}

extension Photo: Equatable { }

func == (lhs: Photo, rhs: Photo) -> Bool {
    return lhs.id == rhs.id
}

extension Photo: Decodable {
    static func decode(_ json: Any) throws -> Photo {
        
        return try Photo(
            id: json => "id",
            createdAt: json => "created_at",
            updatedAt: json => "updated_at",
            width: json => "width",
            height: json => "height",
            colour: json => "color",
            likes: json => "likes",
            description: json =>? "description",
            username: json => "user" => "username",
            urls: json => "urls"
        )
    }
}

struct PhotoUrl {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

extension PhotoUrl: Decodable {
    static func decode(_ json: Any) throws -> PhotoUrl {
        return try PhotoUrl(
            raw: json => "raw",
            full: json => "full",
            regular: json => "regular",
            small: json => "small",
            thumb: json => "thumb"
        )
    }
}
