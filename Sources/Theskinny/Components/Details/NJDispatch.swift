//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/19/23.
//

import Foundation
import Publish
import Plot

fileprivate struct TopOfPageComment {
    static var text = "Ben's note: Contributor Shelly Williams left Louisiana in 2006 to start a post-law-school graduate program of some sort. She finds herself in East Orange, NJ, which turns out to be worthy of stories and pictures."
}

struct NJDispatch: Component {
    var title: String?
    var date: Date
    var content: Content.Body
    var id: Int
    
    var dateString: String {
        EnvironmentKey.defaultDateFormatter.string(from: date)
    }
    
    var linkText: String {
        "Dispatch \(id):  \(title ?? "")"
    }
    
    var body: Component {
        let linkInfo = TopNavLinks.LinkInfo(text: "Back to full list", url: "/njdispatches")
        
        return Article {
            TopNavLinks(leftLinkInfo: linkInfo)
            H3 { Text(TopOfPageComment.text) }
            H1(title ?? "")
            H3(dateString)
            Div(content.body)
        }
    }
}

struct NJDispatches: Component {
    var items: [NJDispatch]
    
    let listStyle = HTMLListStyle(elementName: "") { listItem in
        Div(listItem).class("padded-line")
    }
    
    var body: Component {
        let items = self.items.sorted{ $0.date < $1.date }
        return Article {
            H3 { Text(TopOfPageComment.text) }
            List(items) { item in
                let idStr = "00000\(item.id)".suffix(2)
                return Link(item.linkText, url: "nj\(idStr)")
            }.listStyle(listStyle)
        }
    }
}

