//
//  SearchResultItem.swift
//  Watch Later
//
//  Created by Christopher Kriens on 2/11/21.
//

import Foundation

struct SearchResult: Codable {
    let totalResults: String
    let search: [SearchResultItem]

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
    }
}
