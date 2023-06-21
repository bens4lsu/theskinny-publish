//
//  File.swift
//  
//
//  Created by Ben Schultz on 6/21/23.
//

import Foundation
import Plot
import Publish

struct Video: Component, Decodable {
    let id: Int
    let name: String
    let dateRecorded: Date?
    let caption: String
    let url: String
    let embed: String
    
    var formattedDate: String {
        if let dateRecorded {
            return EnvironmentKey.defaultDateFormatter.string(from: dateRecorded)
        }
        return ""
    }
    
    var autoSlug: String {
        let pattern = "[^A-Za-z0-9\\-]+"
        return name.replacingOccurrences(of: " ", with: "-")
            .replacingOccurrences(of: pattern, with: "", options: [.regularExpression])
            .lowercased()
    }
    
    var link: String { "/vid3/\(autoSlug)" }
    
    private var dateRecordedComponent: Component {
        if dateRecorded == nil {
            return EmptyComponent()
        }
        let formatter = EnvironmentKey.defaultDateFormatter
        return Text(formatter.string(from: dateRecorded!))
    }
    
    // for line items on pages on /vid2
    var body: Component {
        Div {
            Div {
                H2 { Link(name, url: link) }
                Span(Markdown(caption))
            }
            Div{
                Link(url: link) {
                    Text("thumbnail")
                }
            }.class("vid-gal-thumbnail")
        }.class("vid-gal-line-item")
    }
    
    // for pages on /vid3
    var allByMyself: Component {
        Div {
            H1(name)
            H3(formattedDate)
            Div { Text(caption) }
            Div {
                Markdown(embed)
            }.class("embed-featured")
        }
    }
}
