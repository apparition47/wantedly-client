//
//  Photo.swift
//  Library
//
//  Created by Aaron Lee on 2017/09/02.
//  Copyright © 2017 One Fat Giraffe. All rights reserved.
//

import Foundation

struct Photo {
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
}

extension Photo: Equatable { }

func == (lhs: Photo, rhs: Photo) -> Bool {
    return lhs.id == rhs.id
}

struct PhotoUrl {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}
