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
        do {
            let blogPosts = try blog2Section.items.map { item in
                guard let id = item.metadata.id else {
                    throw TsobHTMLFactory.TsobHTMLFactoryError.currentPostMissingIDInMetadata
                }
                let slug = URL(string: item.path.string)?.lastPathComponent ?? item.path.string
                return BlogPost(title: item.title, slug: slug, date: item.date, content: item.content.body, id: id, description: item.metadata.description ?? "Description not provided")
            }.sorted(by: { $0.date < $1.date })
            return BlogPosts(items: blogPosts)
        } catch {
            exit(0)
        }
    }
    
    var allBlogPostsReversed: BlogPosts? {
        guard let tmpBlogPosts = allBlogPosts else {
            return nil
        }
        let reversedItems = tmpBlogPosts.items.reversed() as [BlogPost]
        return BlogPosts(items: reversedItems)
    }
}
