//
//  Service.swift
//  Watch Later
//
//  Created by Christopher Kriens on 2/11/21.
//

import Foundation

class PlaylistManager {
    private let defaults = UserDefaults.standard
    private let playlistItemsKey = "playlistItems"
    private var playlistItems: [SearchResultItem] {
        get {
            guard let data = defaults.object(forKey: playlistItemsKey) as? Data else { return [] }
            guard let items = try? PropertyListDecoder().decode([SearchResultItem].self, from: data) else { return [] }
            return items
        }
        set {
            defaults.setValue(try? PropertyListEncoder().encode(newValue), forKey: playlistItemsKey)
        }
    }

    func add(_ item: SearchResultItem) {
        var items = playlistItems
        items.append(item)
        playlistItems = items
    }

    func remove(_ item: SearchResultItem) {
        playlistItems = playlistItems.filter { $0.id != item.id }
    }

    func isSaved(_ item: SearchResultItem) -> Bool {
        return playlistItems.contains(where: { $0.id == item.id })
    }

    func allSaved() -> [SearchResultItem] {
        return playlistItems
    }
}
