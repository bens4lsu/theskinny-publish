//
//  File.swift
//  
//
//  Created by Ben Schultz on 2023-12-07.
//

import Foundation
import Plot
import Publish


struct TripPosts: Component {
    let items: [TripPost]
    
    init(items: [TripPost]) {
        let sortedItems = items.sorted(by: < )
        self.items = sortedItems
    }
    
    var itemsReversed: [TripPost] {
        items.reversed()
    }
    
    var body: Component {
        Article {
            List(items) { $0.postShortBox }.listStyle(.listAsDivs)
            TripMirror("https://bigtrip.sailvelvetelvis.com/all/")
        }.class("content")
    }
    
    var forHomePage: Component {
        Div {
            H2 { Link("2024 Velvet Elvis Big Trip", url: "/big-trip")}
            List(items) { $0.postHomePageLook }.listStyle(.listAsDivs)
        }.class("divPostShort")
    }
}

