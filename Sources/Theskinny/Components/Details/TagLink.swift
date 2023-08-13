//
//  File.swift
//  
//
//  Created by Ben Schultz on 2023-08-02.
//

import Foundation
import Plot
import Publish

struct TagLinks: Component {
    let tags: Set<Tag>
    
    var tagsSorted: [Tag] {
        Array(tags).sorted{ $0.string < $1.string }
    }
    
    var body: Component {
        Article {
            H1("Tag Links")
            List(tagsSorted) { tag in
                TagLink(tag: tag)
            }.listStyle(.listOfLinks)
        }
    }
}

struct TagLink: Component {
    let tag: Publish.Tag

    var body: Component {
        Link(tag.string, url: "/tags/\(tag.normalizedString())")
    }
}
