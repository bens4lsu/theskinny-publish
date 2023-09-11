//
//  FileManager.swift
//  MastodonGetter
//
//  Created by Ben Schultz on 2023-09-10.
//

import Foundation

class MicroPostFileManager {
    
    let contentFilePath = "/Users/ben/XCode/projects/Publish Web Sites/theskinny/Content/micro-posts/"
    let mediaFilePath = "/Users/ben/Library/Mobile Documents/com~apple~CloudDocs/webdev/sites/theskinny_media/img/micro/"
    let htmlRelativePath = "/img/micro/"
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()
        
    func write(_ post: MastodonResponse) async throws {
        let idStr = String(post.id)
        let fileName = contentFilePath + idStr + ".md"
        let fm = FileManager.default
        if !fm.fileExists(atPath: fileName) && post.inReplyToId == nil || true {
            let media = try await postMedia(post)
            let str = fileContents(post, media)
            try str.write(toFile: contentFilePath + idStr + ".md", atomically: true, encoding: .utf8)
        }
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
        print ("write to \(fileName)")
        try data.write(to: destinationUrl)
        return htmlRelativePath + fileName
    }
    
    
    
    private func fileContents(_ post: MastodonResponse, _ media: String) -> String {
        """
---
date: \(formatter.string(from: post.createdAt))
source: mastodon
sourceUrl: \(post.uri)
---
\(post.content)

<img src="\(media)" alt="image \(media)">
"""

        
    }
}

