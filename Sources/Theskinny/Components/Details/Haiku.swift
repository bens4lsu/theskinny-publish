//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/18/23.
//

import Foundation
import Plot
import Publish

fileprivate struct TopOfPageComment {
    static var text = "Content created by Tyler Cummings from 2005 - 2008.  A truer poet there never was."
}

struct Haiku: Component {
    var title: String?
    var date: Date
    var content: Content.Body
    var id: Int
    
    var dateString: String {
        EnvironmentKey.defaultDateFormatter.string(from: date)
    }
    
    var bodyMain: Component {
        Span {
            H3(dateString)
            Text("")
            content
        }
    }
    
    var body: Component {
        let linkInfo = TopNavLinks.LinkInfo(text: "Back to full list", url: "/haikus")
        
        return Article {
            TopNavLinks(leftLinkInfo: linkInfo)
            H3 { Text(TopOfPageComment.text) }
            H1(title ?? "")
            bodyMain
        }
    }
    
    var bodyWithLinks: Component {
        let idStr = "00000\(id)".suffix(2)
        return Div {
            Link(url: "/haikus/tc\(idStr)") {
                H1(title ?? "_")
            }
            bodyMain
        }.class("haiku-single-entry")
    }
}

struct Haikus: Component {
    var items: [Haiku]
    
    let listStyle = HTMLListStyle(elementName: "") { listItem in
        Div(listItem)
    }
    
    var body: Component {
        let items = self.items.sorted{ $0.date < $1.date }
        return Article {
            H3 { Text(TopOfPageComment.text) }
            List(items) { item in
                item.bodyWithLinks
            }.listStyle(listStyle)
        }
    }
}
