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
        if page.path.string.prefix(5) == "/gal/" {
            return makePageImgGal(for: page, context: context)
        }
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
            case "velvet-elvis/beneteau":
                return makePageBeneteauHome(for: page, context: context)
            case "big-trip-reversed":
                return makePageBigTripReversed(for: page, context: context)
            default:
                return makePageHTMLDefault(for: page, context: context)
            }
        }()

    }
    
    fileprivate func makePageImgGal(for page: Page, context: PublishingContext<Theskinny>) -> HTML {
        let pageTitle = "Photo Gallery on theskinnyonbenny.com"
        var htmlHeadInfo = HeaderInfo(location: context.index, title: pageTitle)
        let imagePath = "/img\(page.path.string)/data/normal.jpg"
        htmlHeadInfo.additionalNodes.append(Node.ogImgNode(imagePath, context: context))
        let pageContent = Article { page.body }
        let pageMain = AnyPageMain(mainContent: pageContent, site: context.site)
        return HTML(
            htmlHeadInfo.node,
            .body(.component(pageMain))
        )
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
        
        var htmlHeadInfo = HeaderInfo(location: context.index, title: pageTitle)
        let imgPath = page.imagePath?.string ?? EnvironmentKey.emptyImg
        let imgNode = Node.ogImgNode(imgPath, context: context)
        htmlHeadInfo.additionalNodes.append(imgNode)
        let pageContent = Article { page.body }
        let pageMain = AnyPageMain(mainContent: pageContent, site: context.site)
        let html = HTML(
            htmlHeadInfo.node,
            .body(.component(pageMain))
        )
        return html
    }
    
    fileprivate func makePageHTMLBlogArchiveByDate(for page: Publish.Page, context: Publish.PublishingContext<Theskinny>)  -> Plot.HTML {
        let htmlHeadInfo = HeaderInfo(location: context.index, title: "Blog Index of Articles by Date")
        let pageContent = context.allBlogPostsReversed.indexByDate
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
        let pageContent = MicroPosts.allYearLinks
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
    
    fileprivate func makePageBeneteauHome(for page: Page, context: PublishingContext<Theskinny>) -> Plot.HTML {
        let htmlHeadInfo = HeaderInfo(location: context.index, title: "Photo galleries on theskinnyonbenny.com")
        let component = VEBeneteauHome(mdComponent: page, posts: context.beneteauBlogPosts)
        let pageMain = AnyPageMain(mainContent: component, site: context.site)
        return HTML(
            htmlHeadInfo.node,
            .body(.component(pageMain))
        )
    }
    
    fileprivate func makePageBigTripReversed(for page: Page, context: PublishingContext<Theskinny>) -> Plot.HTML {
        let htmlHeadInfo = HeaderInfo(location: context.index, title: "Travel Page")
        let btContext = context.bigtripAll
        let mainContent = TripPostsReversed(tripPosts: btContext)
        let pageMain = AnyPageMain(mainContent: mainContent, site: context.site)
        return HTML(
            htmlHeadInfo.node,
            .body(.component(pageMain))
        )
    }
    
}
