//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/15/23.
//

import Publish
import Plot

struct TsobHTMLFactory: HTMLFactory {
    func makeIndexHTML(for index: Publish.Index, context: Publish.PublishingContext<Theskinny>) throws -> Plot.HTML {
        // make index html = home html
        let sections = context.sections
        let section = sections.first(where: { $0.id.rawValue == "home" })!
            
        return try makeHomeHTML(for: index, section: section, context: context)
    }
    
//    Moved to file under HtmlPages
//    func makeSectionHTML(for section: Publish.Section<Site>, context: Publish.PublishingContext<Site>) throws -> Plot.HTML {
//        try makePostsHTML(for: section, context: context)
//    }
    
//    func makeItemHTML(for item: Publish.Item<Site>, context: Publish.PublishingContext<Site>) throws -> Plot.HTML {
//        HTML(.text("Hello item"))
//    }
    
//    func makePageHTML(for page: Publish.Page, context: Publish.PublishingContext<Site>) throws -> Plot.HTML {
//        HTML(.text("Hello page"))
//    }
    
    func makeTagListHTML(for page: Publish.TagListPage, context: Publish.PublishingContext<Theskinny>) throws -> Plot.HTML? {
        HTML(.text("Hello tag list"))
    }
    
//    func makeTagDetailsHTML(for page: Publish.TagDetailsPage, context: Publish.PublishingContext<Site>) throws -> Plot.HTML? {
//        HTML(.text("Hello tag details"))
//    }

    
    
    

}
