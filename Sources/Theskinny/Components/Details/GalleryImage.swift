//
//  File.swift
//  
//
//  Created by Ben Schultz on 2024-01-29.
//

import Foundation
import Plot
import Publish


struct GalleryImage: Component {
    var lineNum: Int
    var imagePath: String
    var thumbnailpath: String
    var caption: String
    
    var body: Component { EmptyComponent() }
    
    var escapedCaption: String {
        Markdown(caption).render().replacingOccurrences(of: "\"", with: "&quot;")
    }
    
    func body(galRoot: String) -> Component {
        Link(url: galRoot + imagePath){
            Image(url: galRoot + thumbnailpath, description: imagePath)
        }.class("lightview")
            .attribute(named: "data-lightview-caption", value: escapedCaption)
            .attribute(named: "data-lightview-group", value: "group1")
    }
}
