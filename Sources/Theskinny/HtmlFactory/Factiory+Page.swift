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

        if page.content.body.html.contains("redirect=\"true\"")
        {
            return  HTML{ page.body }    // can use this for any where the content is already complete.
        }
//        else if page.path.string.prefix(4) == "/gal" 
//        {
//            let htmlHeadInfo = HeaderInfo(location: context.index, title: page.title).node
//            let mainNode: Node<HTML.DocumentContext> = page.body.convertToNode()
//            return HTML(htmlHeadInfo, mainNode)
//        }
        
                    
        return {
            switch page.path {
            case "blog/blogArchiveByDate":
                return makePageHTMLBlogArchiveByDate(for: page, context: context)
            case "adop":
                return makePageHTMLAdopHome(for: page, context: context)
            case "micro-posts":
                return makePageHTMLMicroPosts(for: page, context: context)
            case "pgHome":
                return makePageHTMLDefault(for: page, context: context, content: Galleries(), title: "Photo Galleries")
            case "velvet-elvis/beneteau":
                return makePageBeneteauHome(for: page, context: context)
            case "velvet-elvis/pegasus":
                return makePagePegasusHome(for: page, context: context)
            case "big-trip-reversed":
                return makePageBigTripReversed(for: page, context: context)
            case "mobileSitemap":
                return makePageMobileSitemap(for: page, context: context)
            case "books":
                return makePageHTMLDefault(for: page, context: context, content: Books(), title: "Books Read")
            case "movies":
                return makePageHTMLDefault(for: page, context: context, content: Movies(), title: "Movies Watched")
            case "tv":
                return makePageHTMLDefault(for: page, context: context, content: TVShows(), title: "TV Shows Watched")
            case "elsewhere":
                return makePageHTMLDefault(for: page, context: context, content: ElsewherePage(), title: "Benny Elsewhere")
            default:
                return makePageHTMLDefault(for: page, context: context)
            }
        }()

    }
    
    fileprivate func makePageHTMLDefault(for page: Publish.Page, context: Publish.PublishingContext<Theskinny>)  -> Plot.HTML {
        var htmlHeadInfo = HeaderInfo(location: context.index, title: page.title)
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
        
        
    fileprivate func makePageHTMLDefault(for page: Publish.Page, context: PublishingContext<Theskinny>, content: any Component, title: String) -> Plot.HTML {
        let htmlHeadInfo = HeaderInfo(location: context.index, title: title)
        let pageMain = AnyPageMain(mainContent: content, site: context.site)
        return HTML (
            htmlHeadInfo.node,
            .body(.component(pageMain))
        )
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
    
//    fileprivate func makePagePgHome(for page: Page, context: PublishingContext<Theskinny>) -> Plot.HTML {
//        let htmlHeadInfo = HeaderInfo(location: context.index, title: "Photo galleries on theskinnyonbenny.com")
//        return HTML(
//            htmlHeadInfo.node,
//
//        )
//    }
    
    fileprivate func makePageBeneteauHome(for page: Page, context: PublishingContext<Theskinny>) -> Plot.HTML {
        let htmlHeadInfo = HeaderInfo(location: context.index, title: "Beneteau Velvet Elvis")
        let component = VEBeneteauHome(mdComponent: page, posts: context.beneteauBlogPosts)
        let pageMain = AnyPageMain(mainContent: component, site: context.site)
        return HTML(
            htmlHeadInfo.node,
            .body(.component(pageMain))
        )
    }

    fileprivate func makePagePegasusHome(for page: Page, context: PublishingContext<Theskinny>) -> Plot.HTML {
        let htmlHeadInfo = HeaderInfo(location: context.index, title: "Pegasus Velvet Elvis")
        let component = VEPegasusHome(mdComponent: page)
        let pageMain = AnyPageMain(mainContent: component, site: context.site)
        return HTML(
            htmlHeadInfo.node,
            .body(.component(pageMain))
        )
    }
    
    
    fileprivate func makePageBigTripReversed(for page: Page, context: PublishingContext<Theskinny>) -> Plot.HTML {
        let htmlHeadInfo = HeaderInfo(location: context.index, title: "Travel Page")
        //htmlHeadInfo.additionalNodes.append(BigTripMap().scriptInit)
        let btContext = context.bigtripAll
        let mainContent = TripPostsReversed(tripPosts: btContext)
        let pageMain = AnyPageMain(mainContent: mainContent, site: context.site)
        return HTML(
            htmlHeadInfo.node,
            .body(.component(pageMain))
        )
    }
    
    fileprivate func makePageMobileSitemap(for page: Page, context: PublishingContext<Theskinny>) -> Plot.HTML {
        let htmlHeadInfo = HeaderInfo(location: context.index, title: "Sitemap")
        let component = ComponentGroup {
            H1("Sitemap")
            Menu(.mobileSitemap)
        }
        let pageMain = AnyPageMain(mainContent: component, site: context.site)
        return HTML(
            htmlHeadInfo.node,
            .body(.component(pageMain))
        )
    }
    
}
