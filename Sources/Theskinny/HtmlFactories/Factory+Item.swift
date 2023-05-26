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
    
    enum TsobHTMLFactoryError: Error {
        case contextMissingAllPosts
        case currentPostNotFoundInContext
    }
    
    func makeItemHTML(for item: Publish.Item<Theskinny>, context: Publish.PublishingContext<Theskinny>) throws -> Plot.HTML {
        switch item.sectionID.rawValue {
        case "blog2":
            return try makePostHTML(for: item, context: context)
        case "haikus":
            return makeHaikuHTML(for: item, context: context)
        case "njdispatches":
            return makeNJHTML(for: item, context: context)
            
            //        case "home":
            //            return try makeHomeHTML(for: context.index, section: section, context: context)
            //        case "about":
            //            return HTML(.text("Hello about"))
        default:
            return HTML(.text("Section HTML not yet implemented"))
        }
    }
    
    
    fileprivate func makePostHTML(for item: Item<Theskinny>, context: PublishingContext<Theskinny>) throws -> Plot.HTML {
     
        // have to work with all posts in order to get the links at the top
        guard let allPosts = context.allBlogPosts else {
            throw TsobHTMLFactoryError.contextMissingAllPosts
        }
        guard let post = allPosts.post(withId: item.metadata.id) else {
            throw TsobHTMLFactoryError.currentPostNotFoundInContext
        }
        let htmlHeadInfo = HeaderInfo(location: item, title: "Blog on theskinnyonbenny.com")
        let pageMain = AnyPageMain(mainContent: post, site: context.site)
        return HTML(
            htmlHeadInfo.node,
            .body(.component(pageMain)
           )
        )
    }
    
    fileprivate func makeHaikuHTML(for item: Item<Theskinny>, context: PublishingContext<Theskinny>) -> Plot.HTML {
        let htmlHeadInfo = HeaderInfo(location: item, title: "Tyler's Haikus on theskinnyonbenny.com")
        let haiku = Haiku(title: item.content.title, date: item.content.date, content: item.content.body, id: item.metadata.id)
        let pageMain = AnyPageMain(mainContent: haiku, site: context.site, custPersonImageClass: "topleft-tc", custHeaderClass: "header-tc")

        return HTML(
           //.head(for: context.index, on: context.site, stylesheetPaths: ["/TsobTheme/style.css"]),
            htmlHeadInfo.node,
            .body(.component(pageMain))
        )
    }
    
    fileprivate func makeNJHTML(for item: Item<Theskinny>, context: PublishingContext<Theskinny>) -> Plot.HTML {
        let htmlHeadInfo = HeaderInfo(location: item, title: "Shelly's NJ Dispatches on theskinnyonbenny.com")
        let dispatch = NJDispatch(title: item.content.title, date: item.content.date, content: item.content.body, id: item.metadata.id)
        let pageMain = AnyPageMain(mainContent: dispatch, site: context.site, custPersonImageClass: "topleft-sw", custHeaderClass: "header-sw")

        return HTML(
           //.head(for: context.index, on: context.site, stylesheetPaths: ["/TsobTheme/style.css"]),
            htmlHeadInfo.node,
            .body(.component(pageMain))
        )
    }
    
}
