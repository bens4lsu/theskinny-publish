//
//  File.swift
//  
//
//  Created by Ben Schultz on 2023-12-18.
//

import Foundation
import Plot
import Publish

struct BlogPosts: Component {
    var items: [BlogPost]
    
    var count: Int { items.count }
    
    var formatterLong: DateFormatter {
        let formatterLong = DateFormatter()
        formatterLong.dateFormat = "EEEE, MMMM d, yyyy"
        return formatterLong
    }
    
    var dates: (Date, Date) {
        if count == 0 {
            return (Date(), Date())
        }
        let minDate = items.min(by: { $0.date < $1.date })!.date
        let maxDate = items.max(by: { $0.date < $1.date })!.date
        return (minDate, maxDate)
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
        let items = self.items.sorted{ $1.date < $0.date }
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
        postWithID(id, andRoot: .blog2)
    }
    
    func postInBigTrip(withId id: Int) -> BlogPost? {
        postWithID(id, andRoot: .bigtrip)
    }
    
    private func postWithID(_ id: Int, andRoot rootStr: BlogRoot) -> BlogPost? {
        guard let i = items.firstIndex(where: { $0.id == id }) else {
            return nil
        }
        var post = items[i]
        if i != 0 {
            post.linkToPrev = LinkInfo(text: items[i-1].title, url: "\(rootStr.rawValue)\(items[i-1].slug)")
        }
        if i < count - 1 {
            post.linkToNext = LinkInfo(text: items[i+1].title, url: "\(rootStr.rawValue)\(items[i+1].slug)")
        }
        post.midLink = LinkInfo(text: "Index", url: rootStr.index)
    
        return post
    }
}


