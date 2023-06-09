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
            H2{
                Link(title, url: linkToFull)
            }
            H3(dateString)
            Div(description)
            TopNavLinks(rightLinkInfo: LinkInfo(text: "read", url: linkToFull))
        }.class("divPostShort")
    }
}

struct BlogPosts: Component {
    var items: [BlogPost]
    
    var count: Int { items.count }
    
    var body: Component { return Div { } }
    
    var indexByDate: Component {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM, yyyy"
        
        let formatterLong = DateFormatter()
        formatterLong.dateFormat = "EEEE, MMMM d, yyyy"
        
        var curMonthString = ""
        var result = ComponentGroup(members: [
            H1("Index of Blog Posts by Date")
        ])
        
        for item in items {
            let itemMonthString = formatter.string(from: item.date)
            if itemMonthString != curMonthString {
                result.members.append(H2(itemMonthString))
                curMonthString = itemMonthString
            }
            let formattedItemDate = formatterLong.string(from: item.date)
            result.members.append(
                Paragraph {
                    Link(formattedItemDate + ":  " + item.title, url: item.linkToFull)
                }.class("p-indented")
            )
        }
        return Article { result }
        
    }
    
    func multiPostPageContent(withTopLinks topLinks: TopNavLinks) -> Component {
        Article {
            topLinks
            List(items) { item in
                item.postShortBox
            }.listStyle(.listAsDivs)
        }
    }
    
    func post(withId id: Int) -> BlogPost? {
        guard let i = items.firstIndex(where: { $0.id == id }) else {
            return nil
        }
        var post = items[i]
        if i != 0 {
            post.linkToPrev = LinkInfo(text: items[i-1].title, url: "/blog2/\(items[i-1].slug)")
        }
        if i < count - 1 {
            post.linkToNext = LinkInfo(text: items[i+1].title, url: "/blog2/\(items[i+1].slug)")
        }
        return post
    }
}
