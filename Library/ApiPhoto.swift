//
//  ApiPhoto.swift
//  Library
//
//  Created by Aaron Lee on 2017/09/02.
//  Copyright © 2017 One Fat Giraffe. All rights reserved.
//

import Foundation

struct ApiPhoto: InitializableWithData, InitializableWithJson {
    let id: String
    let createdAt: Date
    let updatedAt: Date
    let width: Int
    let height: Int
    let colour: String
    let likes: Int
    let description: String?
    let username: String?
    let urls: PhotoUrl
    
    init(data: Data?) throws {
        // Here you can parse the JSON or XML using the build in APIs or your favorite libraries
        guard let data = data,
            let jsonObject = try? JSONSerialization.jsonObject(with: data),
            let json = jsonObject as? [String: Any] else {
                throw NSError.createParseError()
        }
        
        try self.init(json: json)
    }
    
    init(json: [String : Any]) throws {
        guard let id = json["id"] as? String,
//            let createdAt = json["created_at"] as? Date,
//            let updatedAt = json["updated_at"] as? Date,
            let width = json["width"] as? Int,
            let height = json["height"] as? Int,
            let colour = json["color"] as? String,
            let likes = json["likes"] as? Int,
//            let description = json["color"] as? String,
            let user = json["user"] as? [String: Any],
            let username = user["username"] as? String,
            let urls = json["urls"] as? [String: Any],
            let urlRaw = urls["raw"] as? String,
            let urlFull = urls["full"] as? String,
            let urlRegular = urls["regular"] as? String,
            let urlSmall = urls["small"] as? String,
            let urlThumb = urls["thumb"] as? String else {
                throw NSError.createParseError()
        }
        
        self.id = id
        self.createdAt = Date()
        self.updatedAt = Date()
        self.width = width
        self.height = height
        self.colour = colour
        self.likes = likes
        self.description = nil
        self.username = username
        self.urls = PhotoUrl(raw: urlRaw, full: urlFull, regular: urlRegular, small: urlSmall, thumb: urlThumb)
    }
}

extension ApiPhoto {
    var photo: Photo {
        return Photo(id: id, createdAt: createdAt, updatedAt: updatedAt, width: width, height: height, colour: colour, likes: likes, description: description, username: username, urls: urls)
    }
}
