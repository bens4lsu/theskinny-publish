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
    var content: String
    var id: Int
    
    var dateString: String {
        EnvironmentKey.defaultDateFormatter.string(from: date)
    }
    
    var bodyMain: Component {
        Span {
            H3(dateString)
            Text("")
            Text(content)
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
        }
    }
}

struct Haikus: Component {
    var items: [Haiku]
    
    var body: Component {
        Article {
            List(items) { item in
                item.bodyWithLinks
            }
        }
    }
}
