//
//  File.swift
//
//
//  Created by Ben Schultz on 5/15/23.
//

import Foundation
import Publish
import Plot

extension TsobHTMLFactory {
    func makeSectionHTML(for section: Section<Theskinny>, context: PublishingContext<Theskinny>) throws -> HTML {
        switch section.id.rawValue {
        case "blog2":
            return try makePostsHTML(for: section, context: context)
        case "haikus":
            return try makeHaikusHTML(for: section, context: context)
            
//        case "home":
//            return try makeHomeHTML(for: context.index, section: section, context: context)
//        case "about":
//            return HTML(.text("Hello about"))
        default:
            return HTML(.text("Section HTML not yet implemented"))
        }
    }
    
    
    func makeHaikusHTML(for section: Section<Theskinny>, context: PublishingContext<Theskinny>) throws -> HTML {
        let haikuArray = section.items.map { item in
            Haiku(title: item.content.title, date: item.content.date, content: item.content.body.html, id: item.metadata.id)
        }
        let haikus = Haikus(items: haikuArray)

        return HTML(
           .head(for: context.index, on: context.site, stylesheetPaths: ["/TsobTheme/style.css"]),
           .body(.tsobHeader(for: context),
                 .wrapper(.article(
                    .component(haikus.body),
                 .tsobFooter(for: context.site)
           )
        )))
    }
}
