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
    let tags: [Tag]
    var injectedComponent: Component = EmptyComponent()
    
    private var _linkOverride: String?
    
    
    init(title: String, slug: String, date: Date, content: Content.Body, id: Int, description: String, linkToPrev: LinkInfo? = nil, linkToNext: LinkInfo? = nil, tags: [Tag]) {
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
            TopNavLinks(leftLinkInfo: linkToPrev, rightLinkInfo: linkToNext)
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

struct BlogPosts: Component {
    var items: [BlogPost]
    
    var count: Int { items.count }
    
    var formatterLong: DateFormatter {
        let formatterLong = DateFormatter()
        formatterLong.dateFormat = "EEEE, MMMM d, yyyy"
        return formatterLong
    }
    
    var body: Component { return EmptyComponent() }
    
    var indexByDate: Component {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM, yyyy"

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
    
    var simpleList: Component {
        var result = ComponentGroup(members: [])
        for item in items {
            let formattedItemDate = formatterLong.string(from: item.date)
            result.members.append(
                Paragraph {
                    Link(formattedItemDate + ":  " + item.title, url: item.linkToFull)
                }.class("p-indented")
            )
        }
        return result
    }
    
    
    var multiPostList: Component {
        let items = self.items.sorted{ $0.date < $1.date }
        return List(items) { item in
            item.postShortBox
        }.listStyle(.listAsDivs)
    }
    
    
    func multiPostPageContent(withTopLinks topLinks: TopNavLinks) -> Component {
        Article {
            topLinks
            multiPostList
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
