//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/24/23.
//

import Foundation
import Publish


extension PublishingContext where Site == Theskinny {
    
    var allBlogPosts: BlogPosts? {
        guard let blog2Section = self.sections.filter({ $0.id == .blog2 }).first
        else {
            return nil
        }
        let blogPosts = blog2Section.items.map { item in
            let slug = URL(string: item.path.string)?.lastPathComponent ?? item.path.string
            return BlogPost(title: item.title, slug: slug, date: item.date, content: item.content.body, id: item.metadata.id, description: item.metadata.description ?? "Description not provided")
        }.sorted(by: { $0.date < $1.date })
        
        return BlogPosts(items: blogPosts)
    }
    
    var allBlogPostsReversed: BlogPosts? {
        guard let tmpBlogPosts = allBlogPosts else {
            return nil
        }
        let reversedItems = tmpBlogPosts.items.reversed() as [BlogPost]
        return BlogPosts(items: reversedItems)
    }
}
