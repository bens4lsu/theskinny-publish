//
//  File.swift
//  
//
//  Created by Ben Schultz on 2023-08-13.
//

import Foundation
import Plot
import Publish

struct TagDetails: Component {
    let tagName: String
    let blogPosts: BlogPosts
    let topNav: TopNavLinks

    
    var body: Component {
        Article {
            topNav
            H1("All posts tagged with \"\(tagName)\"")
            blogPosts.multiPostList
        }
    }
}


