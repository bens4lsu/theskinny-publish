//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/25/23.
//

import Foundation
import Publish
import Plot

struct HomeBlogPost: Component {
    
    let posts: BlogPosts
    
    init(_ posts: BlogPosts) {
        self.posts = posts
    }
    
    var body: Component {
        Div {
            posts.items.last!.postShortBox
        }.class("div-home-latestblog")
    }
}
