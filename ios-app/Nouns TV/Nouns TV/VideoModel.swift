//
//  VideoModel.swift
//  Nouns TV
//
//  Created by PAVEL on 2023/10/13.
//

import Foundation

struct VideoModel: Identifiable, Codable {
    let id = UUID()
    let title: String
    let thumbnailLink: String
    let videoLink: String
    let youtubeLink: String
    let creatorName: String
    let creatorSocialLink: String

    enum CodingKeys: String, CodingKey {
        case title
        case thumbnailLink
        case videoLink
        case youtubeLink
        case creatorName
        case creatorSocialLink
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        thumbnailLink = try container.decode(String.self, forKey: .thumbnailLink)
        videoLink = try container.decode(String.self, forKey: .videoLink)
        youtubeLink = try container.decode(String.self, forKey: .youtubeLink)
        creatorName = try container.decode(String.self, forKey: .creatorName)
        creatorSocialLink = try container.decode(String.self, forKey: .creatorSocialLink)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(thumbnailLink, forKey: .thumbnailLink)
        try container.encode(videoLink, forKey: .videoLink)
        try container.encode(youtubeLink, forKey: .youtubeLink)
        try container.encode(creatorName, forKey: .creatorName)
        try container.encode(creatorSocialLink, forKey: .creatorSocialLink)
    }
}

