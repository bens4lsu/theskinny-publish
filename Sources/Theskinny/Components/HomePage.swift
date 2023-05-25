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
    
    var body: Component {
        Div {
            HomeMainMessage()
            HomeTweets()
            HomeBlogPost()
            HomeDailyPhoto()
            HomeShelly()
        }.class("div-home-wrapper-inner")
    }
}
