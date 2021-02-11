//
//  Service.swift
//  Watch Later
//
//  Created by Christopher Kriens on 2/11/21.
//

import Foundation

enum ServiceError: Error {
    case queryEncoding
    case networkData
    case jsonDecoding
}

let omdbBaseUrl = "https://www.omdbapi.com"
let apiKey = "4a9d2fcc"

class Service {

    static func search(query: String, type: SearchResultItemType = .movie, completion: @escaping (Result<SearchResult, ServiceError>) -> ()) {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            completion(.failure(.queryEncoding))
            return
        }
        let endpoint = "\(omdbBaseUrl)?apikey=\(apiKey)&s=\(encodedQuery)&type=\(type.rawValue)"
        let url = URL(string: endpoint)!

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let rawJson = data else {
                completion(.failure(.networkData))
                return
            }
            guard let decodedResult = try? JSONDecoder().decode(SearchResult.self, from: rawJson) else {
                completion(.failure(.jsonDecoding))
                return
            }
            completion(.success(decodedResult))
        }.resume()
    }
}
