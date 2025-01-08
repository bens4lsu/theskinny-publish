//
//  File.swift
//  Theskinny
//
//  Created by Ben Schultz on 2025-01-08.
//

import Foundation
import XMLParsing
import Files
import Plot


struct AppleMusicData {
    
    static let playlists = {
        do {
            let xmlFiles = try Folder(path: Plot.EnvironmentKey.appleMusicFilePath).files.filter { file in
                file.extension == "xml" &&
                file.name != "Music.xml"
            }
            
            var playlists = [AppleMusicLibPlaylist]()
            
            for file in xmlFiles {
                let xmlData = try file.read()
                let decoded = try XMLDecoder().decode(AppleMusicLibPlaylist.self, from: xmlData)
                playlists.append(decoded)
                
                let trouble = decoded.playlist.filter {$0.artist == nil || $0.album == nil}
                if trouble.count > 0 {
                    print ("Possible problem with track in playlist \(decoded.name)")
                    print(trouble)
                }
            }
            return playlists
        }
            
        catch {
            print ("error loading music XML: \(error)")
            exit(9)
        }
    }()
    
}

