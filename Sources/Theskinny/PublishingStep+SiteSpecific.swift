//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/24/23.
//

import Foundation
import Plot
import Publish

extension PublishingStep where Site == Theskinny {
    
    static func writePostPages() -> Self {
        .step(named: "Write Post Summary Pages") { context in
            guard let allPosts = context.allBlogPostsReversed?.items else { return }
            let factory = TsobHTMLFactory()
            let postsPerPage = EnvironmentKey.blogPostsPerPage
            var numPages = allPosts.count / postsPerPage
            let postsOnLastPage = allPosts.count % postsPerPage
            if postsOnLastPage > 0 {
                numPages += 1
            }
            for i in 0..<numPages {
                var includePosts = [BlogPost]()
                
                let pageName = i == 0 ? "current" : "page-\(i)"
                
                let rightLinkInfo: LinkInfo? = {
                    switch i {
                    case 0:
                        return nil
                    case 1:
                        return LinkInfo(text: "newer", url: "/blog/current")
                    default:
                        return LinkInfo(text: "newer", url: "/blog/page-\(i - 1)")
                    }
                }()
                let leftLinkInfo: LinkInfo? = (i == numPages - 1) ? nil : LinkInfo(text: "older", url: "/blog/page-\(i + 1)")
                let linkInfo = TopNavLinks(leftLinkInfo: leftLinkInfo, rightLinkInfo: rightLinkInfo)
                
                let postsThisPage = (allPosts.count <= (i * postsPerPage + postsPerPage)) ? postsOnLastPage : postsPerPage
                //print ("\(postsThisPage) \(postsPerPage) \(i) \(postsOnLastPage)")
                for j in 0..<(postsThisPage) {
                    //print ("\(allPosts.count)  \(i)  \(j)  \(postsThisPage)  \(i * postsPerPage + j)")
                    includePosts.append(allPosts[i * postsPerPage + j])
                }
                let posts = BlogPosts(items: includePosts)
                let page = Page(path: "blog/\(pageName)/index.html", content: Content())
                let html = factory.makeMultiPageHTML(for: page, context: context, from: posts, withLinks: linkInfo)
                let file = try context.createOutputFile(at: page.path)
                try file.write(html.render(indentedBy: .spaces(4)))
            }
        }
    }
    
    
    static func writeRedirectsFromWordpressUrls() -> Self {
        .step(named: "Write redirects for wordpress urls") { context in
            guard let allPosts = context.allBlogPostsReversed?.items else { return }
            let factory = TsobHTMLFactory()
            for post in allPosts {
                let page = Page(path: "blog2/archives/\(post.id)/index.html", content: Content())
                let html = factory.makeRedirectFromOldBlogPath(for: page, context: context, newName: post.slug)
                let file = try context.createOutputFile(at: page.path)
                try file.write(html.render())
            }
            let max = allPosts.map({ $0.id }).max() ?? -1
            print("NOTICE:  Max blog post id is currently \(max)")
        }
    }
    
    static func writeVideoAlbumPages() -> Self {
        .step(named: "Create video album pages"){ context in
            let factory = TsobHTMLFactory()
            for var album in context.videoAlbums {
                var page = Page(path: "vid2/\(album.slug)/index.html", content: Content())
                page.title = album.name
                album.videos = album.videos.sorted()
                let html = try factory.makeVideoAlbumHtml(for: page, context: context, album: album)
                let file = try context.createOutputFile(at: page.path)
                try file.write(html.render())
                try writeIndivVideoPages(forAlbum: album, usingFactory: factory, onContext: context, backToPage: page)
            }
            try writeRedirect(atPage: "/vid2", to: "/vid", onContext: context)
            try writeRedirect(atPage: "/vid3", to: "/vid", onContext: context)
        }
    }
    
    static func writeIndivVideoPages(forAlbum album: VideoAlbum, usingFactory factory: TsobHTMLFactory, onContext context: PublishingContext<Theskinny>, backToPage: Page) throws {
        for video in album.videos {
            let page = Page(path: "\(video.link)/index.html", content: Content())
            let html = try factory.makeVideoSinglePageHtml(for: page, context: context, video: video, backToPage: backToPage)
            let file = try context.createOutputFile(at: page.path)
            try file.write(html.render())
        }
    }
    
    static func writeRedirect(atPage pagePath: Path, to redirPath: Path, onContext context: PublishingContext<Theskinny>) throws {
        let path = pagePath.appendingComponent("index.html")
        let page = Page(path: path, content: Content())
        let redirectHtml = HTML(.body(.redirect(to: redirPath.string)))
        let file = try context.createOutputFile(at: page.path)
        try file.write(redirectHtml.render())
    }
}
