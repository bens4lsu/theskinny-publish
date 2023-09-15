//
//  File.swift
//  
//
//  Created by Ben Schultz on 6/21/23.
//

import Foundation
import Plot
import Publish

extension HTMLListStyle {
    
    static var listAsDivs: HTMLListStyle {
        HTMLListStyle(elementName: "") { listItem in
            Div(listItem)
        }
    }
    
    static var listOfLinks: HTMLListStyle {
        HTMLListStyle(elementName: "") { listItem in
            Div(listItem).class("list-of-links")
        }
    }
    
    static var inlineListOfLinks: HTMLListStyle {
        HTMLListStyle(elementName: "") { listItem in
            Div(listItem).class("inline-list-of-links")
        }
    }
    
    func componentListOfLinks(links: [Link]) -> Component {
        List(links) { link in
            link
        }.listStyle(.listOfLinks)
    }
}
