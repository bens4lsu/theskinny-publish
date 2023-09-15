//
//  File.swift
//  ParseTwitterJson
//
//  Created by Ben Schultz on 2023-09-15.
//

import Foundation

class MicroPostFileManager {
    
    let contentFilePath = "/Users/ben/XCode/projects/Publish Web Sites/theskinny/Content/micro-posts/"
    let mediaFilePath = "/Users/ben/Library/Mobile Documents/com~apple~CloudDocs/webdev/sites/theskinny_media/img/micro/"
    let htmlRelativePath = "/img/micro/"
    let yamlFile = "/Users/ben/XCode/projects/Publish Web Sites/theskinny/Content-custom/twitter-posts.yaml"
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    func getYaml(_ post: Tweet) async throws -> String {
        if post.in_reply_to_status_id_str == nil {
            var mediaLine = ""
            if let media = post.media_url {
                let mediaFileName = try await postMedia(media)
    //            if mediaFileName.suffix(3) == "mp4" {
    //                mediaLine = mp4Lookup[mediaFileName] ?? ""
    //            }
    //            else
                if mediaFileName.suffix(3) == "jpg" || mediaFileName.suffix(3) == "png" {
                    mediaLine = "<img src=\"/img/micro/\(mediaFileName)\">"
                }
            }
            let str = fileContentsAsYaml(post, mediaLine)
            return str
        }
        return ""
    }


    private func postMedia(_ media: String) async throws -> String {
        let session = URLSession.shared
        guard let url = URL(string: media) else {
            return ""
        }
        let (data, _) = try await session.data(from: url)
        let fileName = mediaFilePath + url.lastPathComponent
        let destinationUrl = URL(fileURLWithPath: fileName)
        try data.write(to: destinationUrl)
        return url.lastPathComponent
    }
    
    private func fileContentsAsYaml(_ post: Tweet, _ media: String) -> String /* return YAML */ {

"""
-
    date: \(formatter.string(from: post.created_at))
    source: twitter
    sourceUrl: https://twitter.com/bens4lsu/status/\(post.id)
    content: |
        \(post.full_text.replacingOccurrences(of: "\n", with: "\n        "))
    media: \(media)
"""

        
    }
}
