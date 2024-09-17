//
//  File.swift
//  
//
//  Created by Ben Schultz on 2024-09-17.
//

import Foundation
import Files
import Yams

struct VideoData {
    
    static let videoAlbums: [VideoAlbum] = {
        let path =  "./Content-custom/video-metadata/"
        let decoder = YAMLDecoder()
        var albums = [VideoAlbum]()
        do {
            try Folder(path: path).files.enumerated().forEach { (index, file) in
                //print (file)
                let fileYaml = try file.readAsString()
                var decoded = try decoder.decode(VideoAlbum.self, from: fileYaml)
                //print ("video gallery \(decoded.id): \(decoded.videos.count) videos")
                let preFilterCount = decoded.videos.count
                decoded.videos = decoded.videos.filter {
                    $0.embed.count > 0
                }
                if decoded.videos.count != preFilterCount {
                    print ("WARNING: videos eliminated because no emded code in \(file.name)")
                }
                if decoded.videos.count > 0 {
                    albums.append(decoded)
                }
            }
        } catch(let e) {
            print ("Video album file or decode error on:  \(e)")
        }
        return albums
    }()
    
    static let bigtripVideos: [Video] = {
        let albumIdsToInclude = [9123001, 9123003]
        let albumsForThisSet = videoAlbums.filter { albumIdsToInclude.contains($0.id) }
        return albumsForThisSet.flatMap { $0.videos }
    }()
}
