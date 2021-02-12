//
//  SearchResultItem.swift
//  Watch Later
//
//  Created by Christopher Kriens on 2/11/21.
//

import Foundation

struct SearchResult: Codable {
    let search: [SearchResultItem]?
    let error: String?

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case error = "Error"
    }

    init() {
        search = [SearchResultItem]()
        error = nil
    }
}
