//
//  Model.swift
//  my_vrg
//
//  Created by Іван Штурхаль on 08.06.2024.
//

import Foundation

struct ArticleResponse: Decodable {
    let status: String
    let num_results: Int
    let results: [Article]
}

struct Article: Decodable, Identifiable {
    let id = UUID()
    let url: String
    let title: String
    let abstract: String
    let byline: String
    let published_date: String
    let media: [Media]?
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case url
        case title
        case abstract
        case byline
        case published_date
        case media
    }
}

struct Media: Codable {
    let type: String
    let subtype: String
    let caption: String
    let media_metadata: [MediaMetadata]
    
    enum CodingKeys: String, CodingKey {
        case type
        case subtype
        case caption
        case media_metadata = "media-metadata"
    }
}

struct MediaMetadata: Codable {
    let url: String
    let format: String
    let height: Int
    let width: Int
}

struct IdentifiableError: Identifiable {
    let id = UUID()
    let error: Error
}
