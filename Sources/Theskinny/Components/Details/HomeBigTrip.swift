//
//  File.swift
//  
//
//  Created by Ben Schultz on 2023-12-07.
//

import Foundation
import Plot
import Publish
import Ink
import Files


struct HomeBigTrip: Component {
    
    var tripPosts: TripPosts
    
    let maxTripPostsOnHome = 3
    
    var littleSet: TripPosts {
        let idx = min(tripPosts.items.count - 1, maxTripPostsOnHome)
        if idx < maxTripPostsOnHome {
            return tripPosts
        }
        let slice = tripPosts.itemsReversed[...idx]
        return TripPosts(items: Array(slice))
    }
    
    var body: Component {
        Div {
            littleSet.forHomePage
        }.class("home-big-trip")
    }
}
