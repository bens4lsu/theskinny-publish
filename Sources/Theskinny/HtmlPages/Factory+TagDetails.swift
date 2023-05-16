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
    func makeTagDetailsHTML(for page: Publish.TagDetailsPage, context: Publish.PublishingContext<Site>) throws -> HTML? {
        HTML(.head(for: context.index, on: context.site),
             .body(
                .tsobHeader(for: context),
                .h1(.text("All posts with the tag \(page.tag.string)")),
                .postContent(for: context.items(taggedWith: page.tag), on: context.site),
                .tsobFooter(for: context.site)
                )
             )
    }
}
