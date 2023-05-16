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
    func makePostsHTML(for section: Section<Site>, context: PublishingContext<Site>) throws -> HTML {
         HTML(
            .head(for: context.index, on: context.site, stylesheetPaths: ["/TsobTheme/style.css"]),
            .body(.tsobHeader(for: context),
                  .postContent(for: section.items, on: context.site),
                  .tsobFooter(for: context.site)
            )
        )
    }
}
