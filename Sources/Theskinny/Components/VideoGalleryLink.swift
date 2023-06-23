//
//  File.swift
//  
//
//  Created by Ben Schultz on 6/22/23.
//

import Foundation
import Plot
import Publish

struct VideoGalleryLink: Component {
    
    let url: String
    let image: String
    let caption: String
    
    var body: Component {
        Div {
            Div {
                Link(url: url) {
                    Image("/img/video-thumbnails/\(image)").class("img-gal-link")
                }.attribute(named: "target", value: "_blank")
            }
            H3(self.caption)
        }.class("div-image-gallery-link")
    }
}

struct VideoGalleryLinkSet: Component {
    
    let links: [VideoGalleryLink]
    
    var body: Component {
        Div {
            List(links) { link in
                link
            }.listStyle(.listAsDivs)
        }.class("div-image-gallery-set")
    }
}
