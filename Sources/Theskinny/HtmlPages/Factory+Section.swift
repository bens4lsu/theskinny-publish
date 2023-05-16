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
    func makeSectionHTML(for section: Section<Site>, context: PublishingContext<Site>) throws -> HTML {
        switch section.id.rawValue {
        case "posts":
            return try makePostsHTML(for: section, context: context)
        case "home":
            return try makeHomeHTML(for: context.index, section: section, context: context)
        case "about":
            return HTML(.text("Hello about"))
        default:
            return HTML(.text("Section HTML not yet implemented"))
        }
    }
}
