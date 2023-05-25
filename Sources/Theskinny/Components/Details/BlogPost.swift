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
    var linkToPrev: TopNavLinks.LinkInfo?
    var linkToNext: TopNavLinks.LinkInfo?
    
    
    var dateString: String {
        EnvironmentKey.defaultDateFormatter.string(from: date)
    }
    
    var linkToFull: String {
        "/blog2/\(slug)"
    }

    var body: Component {
        return Article {
            TopNavLinks(leftLinkInfo: linkToPrev, rightLinkInfo: linkToNext)
            H1(title)
            H3(dateString)
            Div(content.body)
        }
    }
    
    var postShortBox: Component {
        Div {
            H1(title)
            H3(dateString)
            Div(description)
            TopNavLinks(rightLinkInfo: TopNavLinks.LinkInfo(text: "read", url: linkToFull))
        }.class("divPostShort")
    }
}

struct BlogPosts: Component {
    var items: [BlogPost]
    
    var count: Int { items.count }
    
    let listStyle = HTMLListStyle(elementName: "") { listItem in
        Div(listItem)
    }
    
    var body: Component { return Div { } }
    
    func multiPostPageContent(withTopLinks topLinks: TopNavLinks) -> Component {
        Article {
            topLinks
            List(items) { item in
                item.postShortBox
            }.listStyle(listStyle)
        }
    }
    
    func post(withId id: Int) -> BlogPost? {
        guard let i = items.firstIndex(where: { $0.id == id }) else {
            return nil
        }
        var post = items[i]
        if i != 0 {
            post.linkToPrev = TopNavLinks.LinkInfo(text: items[i-1].title, url: "/blog2/\(items[i-1].slug)")
        }
        if i < count - 1 {
            post.linkToNext = TopNavLinks.LinkInfo(text: items[i+1].title, url: "/blog2/\(items[i+1].slug)")
        }
        return post
    }
}
