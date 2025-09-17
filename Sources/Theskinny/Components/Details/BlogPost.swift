//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/24/23.
//

import Foundation
import Plot
import Publish
import Ink
import Files


struct BlogPost: Component {
    
    let title: String
    let slug: String
    let date: Date
    let content: Content.Body
    let id: Int
    let description: String
    var linkToPrev: LinkInfo?
    var linkToNext: LinkInfo?
    var midLink: LinkInfo?
    let tags: [Tag]
    var injectedComponent: Component = EmptyComponent()
    var ogImg: String?
    
    private var _linkOverride: String?
    
    
    init(title: String, slug: String, date: Date, content: Content.Body, id: Int, description: String, linkToPrev: LinkInfo? = nil, linkToNext: LinkInfo? = nil, tags: [Tag], ogImg: String?) {
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
        self.ogImg = ogImg
    }
    
    init(slug: String) {
        let file = try! File(path: "Content/blog2/\(slug).md")
        let md = try! MarkdownParser().parse(file.readAsString())
        let requiredMetadataDateString = md.metadata["date"] ?? ""
        let requiredMetadataDate = EnvironmentKey.yyyyMMddhhmmDateFormatter.date(from: requiredMetadataDateString) ?? Date(timeIntervalSince1970: 0)
        let requriedMetadataIDString = md.metadata["id"] ?? ""
        let requiredMetadataID = Int(requriedMetadataIDString) ?? 0

        self.title = md.metadata["title"] ?? ""
        self.slug =  slug
        self.date = requiredMetadataDate
        self.content = ""
        self.id = requiredMetadataID
        self.description = md.metadata["description"] ?? "Post description missing."
        self.tags = []
        self.ogImg = md.metadata["ogImg"]
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
            TopNavLinks(linkToPrev, midLink, linkToNext)
            H1(title)
            H3(dateString)
            Div(content.body)
            injectedComponent
        }
    }
    
    var imgForShortBox: Component {
        if let ogImg = Theskinny.imagePathFromMetadata(for: self.ogImg) {
            return Div {
                Link(url: linkToFull) {
                    Image(ogImg)
                }
            }.class("divPostThumbnail")
        }
        return EmptyComponent()
    }
    
    var postShortBox: Component {
        Div {
            Div {
                Div {
                    H2{
                        Link(title, url: linkToFull)
                    }
                    H3(dateString)
                    Div(description)
                }.class("divPostStuff")
                imgForShortBox
            }.class("divPostFlexbox")
            TopNavLinks(rightLinkInfo: LinkInfo(text: "read", url: linkToFull)).class("divPostEndLink")
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

