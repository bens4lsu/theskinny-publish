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
        switch section.id.rawValue{
        case "blog2":
            return try makePostsHTML(for: section, context: context)
        case "haikus":
            return try makeHaikusHTML(for: section, context: context)
        case "njdispatches":
            return try makeNJHTML(for: section, context: context)
            
//        case "home":
//            return try makeHomeHTML(for: context.index, section: section, context: context)
//        case "about":
//            return HTML(.text("Hello about"))
        default:
            return HTML(.text("Section HTML not yet implemented"))
        }
    }
    
    
    fileprivate func makeHaikusHTML(for section: Section<Theskinny>, context: PublishingContext<Theskinny>) throws -> HTML {
        let haikuArray = section.items.map { item in
            Haiku(title: item.content.title, date: item.content.date, content: item.content.body, id: item.metadata.id)
        }
        let haikus = Haikus(items: haikuArray)
        let pageMain = AnyPageMain(mainContent: haikus, site: context.site, custPersonImageClass: "topleft-tc", custHeaderClass: "header-tc")

        return HTML(
           .head(for: context.index, on: context.site, stylesheetPaths: ["/TsobTheme/style.css"]),
           .body(.component(pageMain))
        )
    }
    
    fileprivate func makeNJHTML(for section: Section<Theskinny>, context: PublishingContext<Theskinny>) throws -> HTML {
        let dispatchArray = section.items.map { dispatch in
            NJDispatch(title: dispatch.content.title, date: dispatch.content.date, content: dispatch.content.body, id: dispatch.metadata.id)
        }
        let dispatches = NJDispatches(items: dispatchArray)
        let pageMain = AnyPageMain(mainContent: dispatches, site: context.site, custPersonImageClass: "topleft-sw", custHeaderClass: "header-nj")

        return HTML(
           .head(for: context.index, on: context.site, stylesheetPaths: ["/TsobTheme/style.css"]),
           .body(.component(pageMain))
        )
    }
}
