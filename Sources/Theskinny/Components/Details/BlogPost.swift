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
    var linkToPrev: TopNavLinks.LinkInfo?
    var linkToNext: TopNavLinks.LinkInfo?
    
    var dateString: String {
        EnvironmentKey.defaultDateFormatter.string(from: date)
    }

    var body: Component {
        return Article {
            TopNavLinks(leftLinkInfo: linkToPrev, rightLinkInfo: linkToNext)
            H1(title)
            H3(dateString)
            Div(content.body)
        }
    }
}

struct BlogPosts: Component {
    var items: [BlogPost]
    
    var count: Int { items.count }
    
    
    
//    let listStyle = HTMLListStyle(elementName: "") { listItem in
//        Div(listItem).class("padded-line")
//    }
    
    var body: Component {
        let items = self.items.sorted{ $0.date < $1.date }
        return Article {
            List(items) { item in
                return Link(item.title, url: "/blog2\(item.slug)")
            }//.listStyle(listStyle)
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
