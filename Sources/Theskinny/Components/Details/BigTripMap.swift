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
        let repeatCount = Int(rating / 20)
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
        TableHeaderCell { Text("Last Played") }
    }
}

struct AppleMusicLibPlaylist: Decodable, Component {
    var playlist: [AppleMusicLibSong]
    private var _name: String
    var comment: String
    var dateUpdated: Date? 
    
    enum CodingKeys: String, CodingKey {
        case playlist = "song"
        case _name = "pl"
        case comment = "comment"
    }
    
    var name: String {
        _name.replacingOccurrences(of: "% ", with: "")
    }
    
    var dateUpdatedString: String {
        guard let dateUpdated else {
            return ""
        }
        return EnvironmentKey.defaultDateFormatter.string(from: dateUpdated)
    }
    
    var pageName: String {
        let stripped = name.replacingOccurrences(of: " ", with: "")
                            .replacingOccurrences(of: "%", with: "")
        return "/playlist/\(stripped)"
    }
    
    var tableContents: Component {
        ComponentGroup(members: playlist)
    }
    
    var bottomLinks: Component {
        let linkDetails = AppleMusicData.allLinks.filter { link in
            link.url.description != pageName
        }
        
        return Div {
            H3("Other playlists:")
            
            List {
                ComponentGroup(members: linkDetails)
            }.listStyle(.inlineListOfLinks)
        }.class("dailyphoto-otheryears")
    }
    
    var body: Component {
        ComponentGroup {
            bottomLinks
            H1(name)
            H3("Updated \(dateUpdatedString)")
            Text(comment)
            
            Table(header: AppleMusicLibSong.header) {
                tableContents
            }
            
            bottomLinks
        }
    }
}
