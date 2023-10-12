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
            case "adop":
                return makePageHTMLAdopHome(for: page, context: context)
            case "micro-posts":
                return makePageHTMLMicroPosts(for: page, context: context)
            case "pgHome":
                return makePagePgHome(for: page, context: context)
            default:
                return makePageHTMLDefault(for: page, context: context)
            }
        }()

    }
    
    fileprivate func makePageHTMLDefault(for page: Publish.Page, context: Publish.PublishingContext<Theskinny>)  -> Plot.HTML {
        var pageTitle: String {
            switch page.path.string {
            case "pgHome":
                return "Photo Galleries on theskinnyonbenny.com"
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
        let pageMain = AnyPageMain(mainContent: pageContent, site: context.site)
        return HTML (
            htmlHeadInfo.node,
            .body(.component(pageMain))
        )
    }
    
    fileprivate func makePageHTMLAdopHome(for page: Publish.Page, context: Publish.PublishingContext<Theskinny>)  -> Plot.HTML {
        let htmlHeadInfo = HeaderInfo(location: context.index, title: "Russian Adoption Stories")
        let pageContent = AdopHome(context)
        let pageMain = AnyPageMain(mainContent: pageContent, site: context.site)
        return HTML (
            htmlHeadInfo.node,
            .body(.component(pageMain))
        )
    }
    
    fileprivate func makePageHTMLMicroPosts(for page: Publish.Page, context: PublishingContext<Theskinny>) -> Plot.HTML {
        let htmlHeadInfo = HeaderInfo(location: context.index, title: "Micro Posts from Social Media")
        let pageContent = MicroPosts(mposts: context.microPosts, allYears: nil)
        let pageMain = AnyPageMain(mainContent: pageContent, site: context.site)
        return HTML (
            htmlHeadInfo.node,
            .body(.component(pageMain))
        )
    }
    
    fileprivate func makePagePgHome(for page: Page, context: PublishingContext<Theskinny>) -> Plot.HTML {
        let htmlHeadInfo = HeaderInfo(location: context.index, title: "Photo galleries on theskinnyonbenny.com")
        let pageMain = AnyPageMain(mainContent: Galleries(), site: context.site)
        return HTML(
            htmlHeadInfo.node,
            .body(.component(pageMain))
        )
    }
    
}
