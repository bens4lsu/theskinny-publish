//
//  File.swift
//  Theskinny
//
//  Created by Ben Schultz on 2025-01-08.
//

import Foundation
import Plot
import Publish

struct AppleMusicLibSong: Decodable, Component {
    var order: Int
    var artist: String?
    var album: String?
    var name: String
    var rating: UInt8
    var playcount: UInt16
    var genre: String
    var lastPlayed: String
    
    
    var displayRating: String {
        let repeatCount = Int(rating / 10)
        return String(repeating: "⭐️", count: repeatCount)
    }
    
    var body: Component {
        TableRow {
            TableCell { Text(name) }
            TableCell { Text(artist ?? "") }
            TableCell { Text(album ?? "") }
            TableCell { Text(displayRating) }
            TableCell { Text(String(playcount)) }
            TableCell { Text(genre) }
            TableCell { Text(lastPlayed) }
        }
    }
    
    static var header = TableRow {
        TableHeaderCell { Text("Song") }
        TableHeaderCell { Text("Artist") }
        TableHeaderCell { Text("Album") }
        TableHeaderCell { Text("Rating") }
        TableHeaderCell { Text("Play Count") }
        TableHeaderCell { Text("Genre") }
        TableHeaderCell { Text("LastPlayed") }
    }
}

struct AppleMusicLibPlaylist: Decodable, Component {
    var playlist: [AppleMusicLibSong]
    var name: String
    var comment: String
    
    enum CodingKeys: String, CodingKey {
        case playlist = "song"
        case name = "pl"
        case comment = "comment"
    }
    
    var body: Component {
        Table {
            AppleMusicLibSong.header
            ComponentGroup(members: playlist)
        }
    }
}
