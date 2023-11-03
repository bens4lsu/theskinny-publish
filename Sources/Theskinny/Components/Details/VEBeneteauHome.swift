//
//  File.swift
//  
//
//  Created by Ben Schultz on 2023-11-03.
//

import Foundation
import Publish
import Plot
import Files


struct VEBeneteauHome: Component {
    
    var beneteauBlogPosts: BlogPosts
    var mdComponent: Page
    
    init(mdComponent: Page, posts: BlogPosts) {
        self.beneteauBlogPosts = posts
        self.mdComponent = mdComponent
    }
        
    var body: Component {
        Article {
            ComponentGroup {
                Markdown(mdComponent.body.html)
                beneteauBlogPosts.simpleList
                H2("Related Image Galleries")
                ImageGalleryLinkSet(171,170,169,168,160,159,158,157,156,155,152,151,150,137,130,129,114,113,112,111)
            }
        }
    }
}
