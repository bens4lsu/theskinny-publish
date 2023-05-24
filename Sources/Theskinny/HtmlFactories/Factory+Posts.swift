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
    func makePostsHTML(for section: Section<Theskinny>, context: PublishingContext<Theskinny>) throws -> HTML {
         HTML(
//            .head(for: context.index, on: context.site, stylesheetPaths: ["/TsobTheme/style.css"]),
//            .body(.tsobHeader(for: context),
//                  .postContent(for: section.items, on: context.site),
//                  .tsobFooter(for: context.site)
            
            .text("makePostsHTML not implemented")
        )
    }
    
    func makeMultiPageHTML(for page: Publish.Page, context: PublishingContext<Theskinny>, from posts: BlogPosts, withLinks links: TopNavLinks) -> HTML {
        let htmlHeadInfo = HeaderInfo(location: page, title: "Blog on theskinnyonbenny.com")
        let pageMain = AnyPageMain(mainContent: posts.multiPostPageContent(withTopLinks: links), site: context.site)
        return HTML(
            htmlHeadInfo.node,
            .body(.component(pageMain)
           )
        )
    }
}
