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
    let tn: String
    let duration: TimeInterval
    
    var formattedDate: String {
        if let dateRecorded {
            return EnvironmentKey.defaultDateFormatter.string(from: dateRecorded)
        }
        return ""
    }
    
    var formattedDuration: String {
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        if duration >= 3600 {
            formatter.allowedUnits = [.hour, .minute, .second];
        } else {
            formatter.allowedUnits = [.minute, .second];
        }
        guard let durationString = formatter.string(from: duration)
        else {
            return ""
        }
        return "Duration:  \(durationString)"
    }
    
    var autoSlug: String {
        let pattern = "[^A-Za-z0-9\\-]+"
        return name.replacingOccurrences(of: " ", with: "-")
            .replacingOccurrences(of: pattern, with: "", options: [.regularExpression])
            .lowercased()
    }
    
    var link: String { "/vid3/\(autoSlug)" }
    
    var dateRecordedString: String {
        if dateRecorded == nil {
            return ""
        }
        return "Recorded:  " + EnvironmentKey.defaultDateFormatter.string(from: dateRecorded!)
    }
    
//    private var dateRecordedComponent: Component {
//        if dateRecorded == nil {
//            return EmptyComponent()
//        }
//        let formatter = EnvironmentKey.defaultDateFormatter
//        return Text(formatter.string(from: dateRecorded!))
//    }
    
    // for line items on pages on /vid2
    var body: Component {
        Div {
            Div {
                H2 { Link(name, url: link) }
                Span(Markdown(caption))
                H3 { Text("\(dateRecordedString)") }
                H3 { Text("\(formattedDuration)") }
            }
            Div{
                Link(url: link) {
                    Image("/img/video-thumbnails/\(tn)")
                }
            }.class("vid-gal-thumbnail")
        }.class("vid-gal-line-item")
    }
    
    // for pages on /vid3
    func allByMyself(backToPage: Page?) -> Component {
        var navSection: any Component
        if backToPage == nil {
            navSection = EmptyComponent()
        }
        else {
            let linkInfo = LinkInfo(backToPage!.title, "/" + backToPage!.path.string)
            navSection = TopNavLinks(linkInfo, nil, nil)
        }
        return Div {
            navSection
            H1(name)
            H3(formattedDate)
            Div { Text(caption) }
            Div {
                Markdown(embed)
            }.class("embed-featured")
        }
    }
}

extension Video: Comparable {
    static func < (lhs: Video, rhs: Video) -> Bool {
        if lhs.dateRecorded != nil && rhs.dateRecorded != nil {
            return lhs.dateRecorded! < rhs.dateRecorded!
        }
        return lhs.id < rhs.id
    }
    
    static func == (lhs: Video, rhs: Video) -> Bool {
        lhs.id == rhs.id
    }
    
    
}
