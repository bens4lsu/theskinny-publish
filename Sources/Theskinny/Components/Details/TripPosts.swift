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
//        for i in 0..<sortedItems.count {
//            if i < sortedItems.count - 1 {
//                sortedItems[i + 1].prevPage = LinkInfo(sortedItems[i].title, sortedItems[i].linkToFull)
//            }
//            if i > 0 {
//                sortedItems[i - 1].nextPage = LinkInfo(sortedItems[i].title, sortedItems[i].linkToFull)
//            }
//        }
        self.items = sortedItems
    }
    
    var itemsReversed: [TripPost] {
        items.reversed()
    }
    
    var body: Component {
        Article {
            H2 { Link("Real Time Map", url: "/velvet-elvis/real-time-tracking") }
            IFrame(url: EnvironmentKey.predictWindSrc, addBorder: true, allowFullScreen: true, enabledFeatureNames: []).class("iframe-smaller")
            List(items) { $0.postShortBox }.listStyle(.listAsDivs)
            TripMirror("https://bigtrip.sailvelvetelvis.com/all/")
        }.class("content")
    }
    
    var forHomePage: Component {
        Div {
            H2 { Link("2024 Velvet Elvis Big Trip", url: "/big-trip")}
            List(itemsReversed) { $0.postHomePageLook }.listStyle(.listAsDivs)
            Div {
                Div {
                    H4 { Link("Real Time Map", url: "/velvet-elvis/real-time-tracking") }
                }.class("grid-span-2")
                Div {
                    IFrame(url: EnvironmentKey.predictWindSrc, addBorder: false, allowFullScreen: true, enabledFeatureNames: [])
                }.class("grid-span-2 padtop")
            }.class("divH4Sub")
        }.class("divPostShort")
    }
}

