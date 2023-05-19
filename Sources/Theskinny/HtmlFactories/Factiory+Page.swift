//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/18/23.
//

import Foundation
import Plot
import Publish

extension TsobHTMLFactory {
    
    func makePageHTML(for page: Publish.Page, context: Publish.PublishingContext<Theskinny>) throws -> Plot.HTML {
        HTML(
            .head(for: page, on: context.site, stylesheetPaths: ["style.css"]),
            .body(.wrapper(
                .tsobHeader(for: context),
                .component(articleContent(for: page)),
                .tsobAside(for: context),
                .tsobFooter(for: context.site)
            ))
        )
    }
    
    fileprivate func articleContent(for page: Publish.Page) -> Plot.Component {
//        if page.path.string.prefix(11) == "x/haikus/tc" {
//            let haiku = Haiku(title: page.title, date: page.date, content: page.body.html, id: page.id)
//            return haiku.body
//        }
        
        
        return Text ( "page code not implemented" )
    }
    
}
