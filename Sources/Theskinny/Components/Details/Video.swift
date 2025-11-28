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
    let caption: String
    let url: String
    let embed: String
    let tn: String
    let duration: TimeInterval
    let dateRecorded: Date?

    
    private var _title: String?
    
    var title: String {
        get {
            _title ?? name
        }
        set {
            _title = newValue
        }
    }
    
    
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
    
    var link: String { "/video/\(autoSlug)" }
    
    var dateRecordedString: String {
        if dateRecorded == nil {
            return ""
        }
        return "Recorded:  " + EnvironmentKey.defaultDateFormatter.string(from: dateRecorded!)
    }
    
    // for line items on pages on /video-albums
    var body: Component {
        Div {
            Div {
                H2 { Link(title, url: link) }
                Span(Markdown(caption))
                H3 { Text("\(dateRecordedString)") }
                H3 { Text("\(formattedDuration)") }
            }.class("vid-gal-stuff")
            Div{
                Link(url: link) {
                    Image("/img/video-thumbnails/\(tn)")
                }
            }.class("vid-gal-thumbnail")
        }.class("vid-gal-line-item")
    }
    
    // for pages on /video
    func allByMyself(backToPage: Page?, injectedComponent: Component = EmptyComponent()) -> Component {
        var navSection: any Component
        if backToPage == nil {
            navSection = EmptyComponent()
        }
        else {
            let linkInfo = LinkInfo(backToPage!.title, backToPage!.path.string)
            navSection = TopNavLinks(linkInfo, nil, nil)
        }
        
        return Div {
            navSection
            H1(name)
            H3(formattedDate)
            Div { Markdown(caption) }
            Div {
                Markdown(embed)
            }.class("embed-featured")
            injectedComponent
        }
    }

}

extension Video: Comparable {
    static func < (lhs: Video, rhs: Video) -> Bool {
        if lhs.dateRecorded != nil
            && rhs.dateRecorded != nil
            && !(lhs.dateRecorded == rhs.dateRecorded)
        {
            return lhs.dateRecorded! < rhs.dateRecorded!
        }
        return lhs.id < rhs.id
    }
    
    static func == (lhs: Video, rhs: Video) -> Bool {
        lhs.id == rhs.id
    }
}
