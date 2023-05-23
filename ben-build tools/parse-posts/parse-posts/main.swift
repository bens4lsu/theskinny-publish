//
//  main.swift
//  parse-posts
//
//  Created by Ben Schultz on 5/23/23.
//

import Foundation




struct SinglePost: Codable {
    let postDate: Date
    let title: String
    let id: Int
    let slug: String
    let tagNames: String
    let tagSlugs: String
    let postContent: String

    enum CodingKeys: String, CodingKey {
        case postDate = "post_date"
        case title = "post_title"
        case id = "ID"
        case slug
        case tagNames = "tag_names"
        case tagSlugs = "tag_slugs"
        case postContent = "post_content"
    }

    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<SinglePost.CodingKeys> = try decoder.container(keyedBy: SinglePost.CodingKeys.self)
        self.postDate = try container.decode(Date.self, forKey: SinglePost.CodingKeys.postDate)
        //self.postDate = Date()
        self.title = try container.decode(String.self, forKey: SinglePost.CodingKeys.title)
        self.id = try container.decode(Int.self, forKey: SinglePost.CodingKeys.id)
        self.slug = try container.decode(String.self, forKey: SinglePost.CodingKeys.slug)
        self.tagNames = try container.decode(String.self, forKey: SinglePost.CodingKeys.tagNames)
        self.tagSlugs = try container.decode(String.self, forKey: SinglePost.CodingKeys.tagSlugs)
        self.postContent = try container.decode(String.self, forKey: SinglePost.CodingKeys.postContent)
    }
    
    static let formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: -300)
        return dateFormatter
    }()
    
    
    var content: String {
            """
---
date: \(SinglePost.formatter.string(from: postDate))
description: A description of my post.
tags: \(tagSlugs)
id: \(id)
---
\(postContent)
"""
    }
    
}

func parseJSON() -> [SinglePost] {
    do {
        let path =  "/Users/ben/XCode/projects/Publish Web Sites/theskinny/ben-build tools/posts.json"
        let url = URL(fileURLWithPath: path)
        let data = try Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(SinglePost.formatter)
        let result = try decoder.decode([SinglePost].self, from: data)
        return result
    }
    catch {
        print ("Could not initialize data. \n \(error)")
        exit(0)
    }
}


let posts = parseJSON()
for post in posts {
    let filename = "/Users/ben/XCode/projects/Publish Web Sites/theskinny/Content/blog2/" + post.slug + ".md"
    let url = URL(fileURLWithPath: filename)
    do {
        try post.content.write(to: url, atomically: true, encoding: String.Encoding.utf8)
    } catch {
        print ("Could not write to file \(filename). \n \(error)")
        exit(0)
    }
}




