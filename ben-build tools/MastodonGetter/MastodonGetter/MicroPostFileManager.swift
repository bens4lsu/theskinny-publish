//
//  FileManager.swift
//  MastodonGetter
//
//  Created by Ben Schultz on 2023-09-10.
//

import Foundation

class MicroPostFileManager {
    
    let contentFilePath = "/Users/ben/XCode/projects/Publish Web Sites/theskinny/Content/micro-posts/"
    let mediaFilePath = "/Volumes/BenPortData/theskinny-media/img/micro/"
    let htmlRelativePath = "/img/micro/"
    let yamlFile = "/Users/ben/XCode/projects/Publish Web Sites/theskinny/Content-custom/mastodon-posts.yaml"
    
    let mp4Lookup = [
        "ca1909ab10e61040.mp4" : "<iframe width=\"200\" height=\"112\" src=\"https://www.youtube.com/embed/m7ukv-ZWi4o\" title=\"\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share\" allowfullscreen></iframe>",
    ]
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
        
    func getYaml(_ post: MastodonResponse) async throws -> String {        
        if post.inReplyToId == nil {
            var mediaLine = ""
            let mediaFileName = try await postMedia(post)
            if mediaFileName.suffix(3) == "mp4" {
                mediaLine = mp4Lookup[mediaFileName] ?? ""
            }
            else if mediaFileName.suffix(3) == "jpg" || mediaFileName.suffix(3) == "png" {
                mediaLine = "<img src=\"/img/micro/\(mediaFileName)\">"
            }
            
            let str = fileContentsAsYaml(post, mediaLine)
            return str
        }
        return ""
    }
    
    
    private func postMedia(_ post:MastodonResponse) async throws -> String {
        guard let media = post.mediaAttachments.first else {
            return ""
        }
        
        let session = URLSession.shared
        guard let url = URL(string: media.url) else {
            return ""
        }
        let (data, _) = try await session.data(from: url)
        let fileName = mediaFilePath + url.lastPathComponent
        let destinationUrl = URL(fileURLWithPath: fileName)
        try data.write(to: destinationUrl)
        return url.lastPathComponent
    }
    
    
    
    private func fileContentsAsYaml(_ post: MastodonResponse, _ media: String) -> String /* return YAML */ {

"""
-
    date: \(formatter.string(from: post.createdAt))
    source: mastodon
    sourceUrl: \(post.uri)
    content: |
        \(post.content.replacingOccurrences(of: "\n", with: "\n\t\t"))
    media: \(media)
"""

        
    }
}

