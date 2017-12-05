//
//  Project.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation
import Decodable
import protocol Decodable.Decodable
import enum Decodable.DecodingError
import struct Decodable.KeyPath

struct Project {
    let id: Int
    let title: String
    let publishedAt: String // TODO decode date
    let supporterCount: Int
    let pageViews: Int
    let candidateCount: Int
    let address: String
    let addressSuffix: String?
    let description: String?
    let hiring: String
    let images: ImageUrl?
//    let tags: [String] // TODO unsure of object type
//    let categoryImages: [String] // TODO unsure of object type
    let categoryMessage: String
    let shouldUseWebView: Bool
    let company: Company
    let staffCount: Int
    let staff: [Staff]
    let canSupport: Bool
    let didSupport: Bool
    let canBookmark: Bool
    let leader: Leader?
    let hasVideo: Bool
}

extension Project: Equatable { }

func == (lhs: Project, rhs: Project) -> Bool {
    return lhs.id == rhs.id
}

extension Project: Decodable {
    static func decode(_ json: Any) throws -> Project {
        
        return try Project(
            id: json => "id",
            title: json => "title",
            publishedAt: json => "published_at",
            supporterCount: json => "support_count",
            pageViews: json => "page_view",
            candidateCount: json => "candidate_count",
            address: json => "location",
            addressSuffix: json =>? "location_suffix",
            description: json =>? "description",
            hiring: json => "looking_for",
            images: json =>? "image",
//            tags: json => "tags",
//            categoryImages: json => "category_images",
            categoryMessage: json => "category_message",
            shouldUseWebView: json => "use_webview",
            company: json => "company",
            staffCount: json => "staffings_count",
            staff: json => "staffings",
            canSupport: json => "can_support",
            didSupport: json => "supported",
            canBookmark: json => "can_bookmark",
            leader: json =>? "leader",
            hasVideo: json => "video_available"
        )
    }
}

struct ImageUrl {
    let icon320: String
    let icon320Retina: String
    let iPhone5: String
    let icon105: String
    let icon105Retina: String
    let icon255: String
    let icon255Retina: String
    let icon50: String
    let icon50Retina: String
    let icon304: String
    let icon304Retina: String
    let caption: String?
    let original: String
}

extension ImageUrl: Decodable {
    static func decode(_ json: Any) throws -> ImageUrl {
        return try ImageUrl(
            icon320: json => "i_320_131",
            icon320Retina: json => "i_320_131_x2",
            iPhone5: json => "max_1136",
            icon105: json => "i_105_130",
            icon105Retina: json => "i_105_130_x2",
            icon255: json => "i_255_70",
            icon255Retina: json => "i_255_70_x2",
            icon50: json => "i_50_50",
            icon50Retina: json => "i_50_50_x2",
            icon304: json => "i_304_124",
            icon304Retina: json => "i_304_124_x2",
            caption: json =>? "caption",
            original: json => "original"
        )
    }
}


struct Company {
    let id: Int
    let name: String
    let founder: String?
    let foundedOn: String? // TODO parse as YYYY-MM-DD NSDate
    let payrollNumber: Int?
    let addressPrefix: String?
    let addressSuffix: String?
//    let latitude: Double?
//    let longitude: Double?
    let url: String?
    let avatar: Avatar?
}

extension Company: Decodable {
    static func decode(_ json: Any) throws -> Company {
        return try Company(
            id: json => "id",
            name: json => "name",
            founder: json =>? "founder",
            foundedOn: json =>? "founded_on",
            payrollNumber: json =>? "payroll_number",
            addressPrefix: json =>? "address_prefix",
            addressSuffix: json =>? "address_suffix",
//            latitude: json =>? "latitude",
//            longitude: json =>? "longitude",
            url: json =>? "url",
            avatar: json =>? "avatar"
        )
    }
}

struct Avatar {
    let original: String
    let size20: String
    let size30: String
    let size40: String
    let size50: String
    let size60: String
    let size100: String
}

extension Avatar: Decodable {
    static func decode(_ json: Any) throws -> Avatar {
        return try Avatar(
            original: json => "original",
            size20: json => "s_20",
            size30: json => "s_30",
            size40: json => "s_40",
            size50: json => "s_50",
            size60: json => "s_60",
            size100: json => "s_100"
        )
    }
}

struct Staff {
    let userId: Int
    let isLeader: Bool
    let name: String
    let facebookUid: String?
    let description: String?
}

extension Staff: Decodable {
    static func decode(_ json: Any) throws -> Staff {
        return try Staff(
            userId: json => "user_id",
            isLeader: json => "is_leader",
            name: json => "name",
            facebookUid: json =>? "facebook_uid",
            description: json =>? "description"
        )
    }
}

struct Leader {
    let nameJa: String?
    let nameEn: String?
    let facebookUid: String?
}

extension Leader: Decodable {
    static func decode(_ json: Any) throws -> Leader {
        return try Leader(
            nameJa: json =>? "name_ja",
            nameEn: json =>? "name_en",
            facebookUid: json =>? "facebook_uid"
        )
    }
}
