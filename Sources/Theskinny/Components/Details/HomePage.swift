//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/25/23.
//

import Foundation
import Publish
import Plot

struct HomePage: Component {
    
    var context: PublishingContext<Theskinny>
    
    init(_ context: PublishingContext<Theskinny>) {
        self.context = context
    }
    
    var body: Component {
        Article {
            Div {
                HomeMainMessage(context)
                HomeBluesky()
                HomeBlogPost(context.allBlogPosts!)
                HomeBigTrip(tripPosts: context.bigtripAll)
                HomeDailyPhoto()
                HomeShelly()
                HomeAfterThought(context)
            }.class("div-home-wrapper-inner")
        }
    }
}
