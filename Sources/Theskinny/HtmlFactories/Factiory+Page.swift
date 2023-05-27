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
    func makePageHTML(for page: Publish.Page, context: Publish.PublishingContext<Theskinny>)  -> Plot.HTML {
        return {
            switch page.path {
            case "blog/blogArchiveByDate":
                return makePageHTMLBlogArchiveByDate(for: page, context: context)
            default:
                return makePageHTMLDefault(for: page, context: context)
            }
        }()

    }
    
    fileprivate func makePageHTMLDefault(for page: Publish.Page, context: Publish.PublishingContext<Theskinny>)  -> Plot.HTML {
        var pageTitle: String {
            switch page.path.string {
            case "pgHome":
                return "Daily photos on theskinnyonbenny.com"
            default:
                return "theskinnyonbenny.com"
            }
        }
        
        let htmlHeadInfo = HeaderInfo(location: context.index, title: pageTitle)
        let pageContent = Article { page.body }
        let pageMain = AnyPageMain(mainContent: pageContent, site: context.site)
        return HTML(
            htmlHeadInfo.node,
            .body(.component(pageMain))
        )
    }
    
    fileprivate func makePageHTMLBlogArchiveByDate(for page: Publish.Page, context: Publish.PublishingContext<Theskinny>)  -> Plot.HTML {
        let htmlHeadInfo = HeaderInfo(location: context.index, title: "Blog Index of Articles by Date")
        guard let pageContent = context.allBlogPostsReversed?.indexByDate else {
            return makePageHTMLDefault(for: page, context: context)
        }
        let pageMain = AnyPageMain(mainContent: pageContent, site: context.site, debug: true)
        return HTML (
            htmlHeadInfo.node,
            .body(.component(pageMain))
        )
    }
    
}
