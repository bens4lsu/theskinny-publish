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
        case "adopK":
            return try makeAdopHtml(for: section, context: context, name: "Kolya", component: context.adopPosts?.adopK)
        case "adopV":
            return try makeAdopHtml(for: section, context: context, name: "Vanya", component: context.adopPosts?.adopV)
            
//        case "home":
//            return try makeHomeHTML(for: context.index, section: section, context: context)
//        case "about":
//            return HTML(.text("Hello about"))
        default:
            return HTML(.text("Section HTML not yet implemented"))
        }
    }
    
    
    fileprivate func makeHaikusHTML(for section: Section<Theskinny>, context: PublishingContext<Theskinny>) throws -> HTML {
        let htmlHeadInfo = HeaderInfo(location: context.index, title: "Tyler's Haikus on theskinnyonbenny.com")
        let haikuArray = try section.items.map { item in
            guard let id = item.metadata.id else {
                throw TsobHTMLFactoryError.currentPostMissingIDInMetadata
            }
            return Haiku(title: item.content.title, date: item.content.date, content: item.content.body, id: id)
        }
        let haikus = Haikus(items: haikuArray)
        let pageMain = AnyPageMain(mainContent: haikus, site: context.site, custPersonImageClass: "topleft-tc", custHeaderClass: "header-tc")

        return HTML(
           //.head(for: context.index, on: context.site, stylesheetPaths: ["/TsobTheme/style.css"]),
            htmlHeadInfo.node,
            .body(.component(pageMain))
        )
    }
    
    fileprivate func makeNJHTML(for section: Section<Theskinny>, context: PublishingContext<Theskinny>) throws -> HTML {
        let htmlHeadInfo = HeaderInfo(location: context.index, title: "Shelly's NJ Dispatches on theskinnyonbenny.com")
        let dispatchArray = try section.items.map { dispatch in
            guard let id = dispatch.metadata.id else {
                throw TsobHTMLFactoryError.currentPostMissingIDInMetadata
            }
            return NJDispatch(title: dispatch.content.title, date: dispatch.content.date, content: dispatch.content.body, id: id)
        }
        let dispatches = NJDispatches(items: dispatchArray)
        let pageMain = AnyPageMain(mainContent: dispatches, site: context.site, custPersonImageClass: "topleft-sw", custHeaderClass: "header-nj")

        return HTML(
           //.head(for: context.index, on: context.site, stylesheetPaths: ["/TsobTheme/style.css"]),
            htmlHeadInfo.node,
            .body(.component(pageMain))
        )
    }
    
    fileprivate func makeAdopHtml(for section: Section<Theskinny>, context: PublishingContext<Theskinny>, name: String, component: Component?) throws -> HTML {
        guard let component = component else {
            throw TsobHTMLFactoryError.adopPostWihtoutSection
        }
        let htmlHeadInfo = HeaderInfo(location: context.index, title: "\(name)'s Adoption Page")
        let pageMain = AnyPageMain(mainContent: component, site: context.site, custHeaderClass: "header-rus")
        
        return HTML (
            htmlHeadInfo.node,
            .body(.component(pageMain))
        )
        
    }
}
