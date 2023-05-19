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
        HTML(
           .head(for: context.index, on: context.site, stylesheetPaths: ["/TsobTheme/style.css"]),
           .body(.tsobHeader(for: context),
                 .wrapper(.article(.contentBody(item.body))),
                 .tsobFooter(for: context.site)
           )
        )
    }
    
}
