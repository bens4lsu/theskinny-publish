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
    
    var localHead: Node<HTML.DocumentContext> {
        let site = Theskinny()
        
        
        return .head(
        .encoding(.utf8),
        .siteName(site.name),
        //.url(site.url(for: location)),
        //.title(site.title),
        .description(site.description),
        //.twitterCardType(location.imagePath == nil ? .summary : .summaryLargeImage),
        //.forEach(stylesheetPaths, { .stylesheet($0) }),
        .viewport(.accordingToDevice),
        .unwrap(site.favicon, { .favicon($0) }),
        //.unwrap(rssFeedPath, { path in
        //    let title = rssFeedTitle ?? "Subscribe to \(site.name)"
        //    return .rssFeedLink(path.absoluteString, title: title)
        //}),
        //.unwrap(location.imagePath ?? site.imagePath, { path in
        //    let url = site.url(for: path)
        //    return .socialImageLink(url)
        //}
            .script(<#T##nodes: HTML.ScriptContext...##HTML.ScriptContext#>)
        )
    }
    
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
