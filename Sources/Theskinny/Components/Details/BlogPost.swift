//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/24/23.
//

import Foundation
import Plot
import Publish

struct BlogPost: Component {
    
    let title: String
    let slug: String
    let date: Date
    let content: Content.Body
    let id: Int
    let description: String
    var linkToPrev: LinkInfo?
    var linkToNext: LinkInfo?
    var midLink: LinkInfo?
    let tags: [Tag]
    var injectedComponent: Component = EmptyComponent()
    let ogImg: String?
    
    private var _linkOverride: String?
    
    
    init(title: String, slug: String, date: Date, content: Content.Body, id: Int, description: String, linkToPrev: LinkInfo? = nil, linkToNext: LinkInfo? = nil, tags: [Tag], ogImg: String?) {
        self.title = title
        self.slug = slug
        self.date = date
        self.content = content
        self.id = id
        self.description = description
        self.linkToPrev = linkToPrev
        self.linkToNext = linkToNext
        self.tags = tags
        self._linkOverride = nil
        self.ogImg = ogImg
    }
    
    var dateString: String {
        EnvironmentKey.defaultDateFormatter.string(from: date)
    }
    
    var linkToFull: String {
        get {
            _linkOverride ?? "/blog2/\(slug)"
        }
        set {
            _linkOverride = newValue
        }
    }

    var body: Component {
        return Article {
            TopNavLinks(linkToPrev, midLink, linkToNext)
            H1(title)
            H3(dateString)
            Div(content.body)
            injectedComponent
        }
    }
    
    var postShortBox: Component {
        Div {
            H2{
                Link(title, url: linkToFull)
            }
            H3(dateString)
            Div(description)
            TopNavLinks(rightLinkInfo: LinkInfo(text: "read", url: linkToFull))
        }.class("divPostShort")
    }
}

//extension BlogPost: Comparable {
//    static func == (lhs: BlogPost, rhs: BlogPost) -> Bool {
//        lhs.date == rhs.date
//    }
//    
//    static func < (lhs: BlogPost, rhs: BlogPost) -> Bool {
//        lhs.date < rhs.date
//    }
//}

