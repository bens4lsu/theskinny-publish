//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/16/23.
//

import Foundation
import Publish
import Plot

extension TsobHTMLFactory {
    func makeItemHTML(for item: Publish.Item<Theskinny>, context: Publish.PublishingContext<Theskinny>) throws -> Plot.HTML {
        switch item.sectionID.rawValue {
        case "blog2":
            return makePostHTML(for: item, context: context)
        case "haikus":
            return makeHaikuHTML(for: item, context: context)
        case "njdispatches":
            return try makeNJHTML(for: item, context: context)
            
            //        case "home":
            //            return try makeHomeHTML(for: context.index, section: section, context: context)
            //        case "about":
            //            return HTML(.text("Hello about"))
        default:
            return HTML(.text("Section HTML not yet implemented"))
        }
    }
    
    fileprivate func makePostHTML(for item: Item<Theskinny>, context: PublishingContext<Theskinny>) -> Plot.HTML {
        HTML(
           .head(for: context.index, on: context.site, stylesheetPaths: ["/TsobTheme/style.css"]),
           .body(.tsobHeader(for: context),
                 .wrapper(.article(.contentBody(item.body))),
                 .tsobFooter(for: context.site)
           )
        )
    }
    
    fileprivate func makeHaikuHTML(for item: Item<Theskinny>, context: PublishingContext<Theskinny>) -> Plot.HTML {
        let haiku = Haiku(title: item.content.title, date: item.content.date, content: item.content.body, id: item.metadata.id)
        let pageMain = AnyPageMain(mainContent: haiku, site: context.site, custPersonImageClass: "topleft-tc", custHeaderClass: "header-tc")

        return HTML(
           .head(for: context.index, on: context.site, stylesheetPaths: ["/TsobTheme/style.css"]),
           .body(.component(pageMain))
        )
    }
    
    fileprivate func makeNJHTML(for item: Item<Theskinny>, context: PublishingContext<Theskinny>) -> Plot.HTML {
        let dispatch = NJDispatch(title: item.content.title, date: item.content.date, content: item.content.body, id: item.metadata.id)
        let pageMain = AnyPageMain(mainContent: dispatch, site: context.site, custPersonImageClass: "topleft-sw", custHeaderClass: "header-sw")

        return HTML(
           .head(for: context.index, on: context.site, stylesheetPaths: ["/TsobTheme/style.css"]),
           .body(.component(pageMain))
        )
    }
    
}
