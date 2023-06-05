//
//  File.swift
//  
//
//  Created by Ben Schultz on 6/4/23.
//

import Foundation
import Plot
import Publish

struct ImageGalleryLinkSet: Component {
    
    var links: [ImageGalleryLink]
    
    let listStyle = HTMLListStyle(elementName: "") { listItem in
        Div(listItem)
    }
    
    init(_ ids: Int...) {
        self.links = ids.map { id in ImageGalleryLink(id) }
    }
    
    var body: Component {
        Div {
            List(links) { link in
                link
            }.listStyle(listStyle)
        }.class("div-image-gallery-set")
    }
    
    func maxWidth(_ set: String) -> Component {
        self.body.style("max-width: \(set)")
    }
}


struct ImageGalleryLink: Component {
    
    struct FromDynamicLookup: Decodable {
        var name: String
        var normalImagePath: String
        var redImagePath: String
    }
    
    var galleryId: Int
    var caption: String
    var redLink: String
    var normalLink: String
    
    
    var body: Component {
        Div {
            Div {
                Link(url: "https://dynamic.theskinnyonbenny.com/\(self.galleryId)") {
                    Image(self.normalLink)
                }
            }
            H3(self.caption)
        }.class("div-image-gallery-link")
    }
    
    init (_ id: Int) {
        self.galleryId = id
        let galleryInfo = galArray[id]!
        self.caption = galleryInfo.name
        self.normalLink = galleryInfo.normalImagePath
        self.redLink = galleryInfo.redImagePath
    }
    
    
    let galArray: [Int: FromDynamicLookup] = [
        31: FromDynamicLookup(name: "Russia Trip 1 - Yaroslavl and Ivan",
                              normalImagePath: "https://dynamic.theskinnyonbenny.com/gal/031 - Russia Trip 1 - Yaroslavl and Ivan/data/normal.jpg",
                              redImagePath: "https://dynamic.theskinnyonbenny.com/gal/031 - Russia Trip 1 - Yaroslavl and Ivan/data/red.jpg"),
        32: FromDynamicLookup(name: "Russia Trip 1 - Moscow",
                              normalImagePath: "https://dynamic.theskinnyonbenny.com/gal/032 - Russia Trip 1 - Moscow/data/normal.jpg",
                              redImagePath: "https://dynamic.theskinnyonbenny.com/gal/032 - Russia Trip 1 - Moscow/data/red.jpg"),
        99: FromDynamicLookup(name: "Krewe of Mutts 2013",
                              normalImagePath: "https://dynamic.theskinnyonbenny.com/gal/099 - Krewe of Mutts 2013/data/normal.jpg",
                              redImagePath: "https://dynamic.theskinnyonbenny.com/gal/099 - Krewe of Mutts 2013/data/red.jpg"),
    ]
}



