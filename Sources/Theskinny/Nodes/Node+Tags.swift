//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/16/23.
//

import Foundation
import Publish
import Plot

extension Node where Context == HTML.BodyContext {
    
    static func tagList<T: Website>(for tags: [Tag], on site: T) -> Node {
        .div(.forEach(tags) { tag in
            .a(.class("post-category post-category-\(tag.string.lowercased())"),
               .href(site.path(for: tag)),
               .text(tag.string)
            )
        })
    }
}
