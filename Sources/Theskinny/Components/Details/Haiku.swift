//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/18/23.
//

import Foundation
import Plot
import Publish

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
        Article {
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
            List(items) { item in
                item.bodyWithLinks
            }.listStyle(listStyle)
        }
    }
}
