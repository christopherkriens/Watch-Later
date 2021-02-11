//
//  SearchResultItem.swift
//  Watch Later
//
//  Created by Christopher Kriens on 2/11/21.
//

import Foundation

enum SearchResultItemType: String, Codable {
    case movie
    case series
    case episode
}

struct SearchResultItem: Codable {
    let id: String
    let title: String
    let year: String
    let type: SearchResultItemType
    let poster: String

    enum CodingKeys: String, CodingKey {
        case id = "imdbID"
        case title = "Title"
        case year = "Year"
        case type = "Type"
        case poster = "Poster"
    }
}
