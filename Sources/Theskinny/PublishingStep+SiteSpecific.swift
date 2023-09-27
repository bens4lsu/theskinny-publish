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
                var page = Page(path: "blog/\(pageName)", content: Content())
                //let html = factory.makeMultiPageHTML(for: page, context: context, from: posts, withLinks: linkInfo)
                let html = HTML(.component(posts.multiPostPageContent(withTopLinks: linkInfo)))
                page.body.html = html.render()
                context.addPage(page)
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
            var maxVideoId = Int.min
            var maxAlbumId = Int.min
            for var album in context.videoAlbums {
                var page = Page(path: "video-albums/\(album.slug)", content: Content())
                page.title = album.name
                album.videos = album.videos.sorted()
                let albumMax = album.videos.map { $0.id }.max() ?? Int.min
                if albumMax > maxVideoId {
                    maxVideoId = albumMax
                }
                if album.id > maxAlbumId {
                    maxAlbumId = album.id
                }
                let html = HTML(.component(album))
                page.content.body.html = html.render()
                context.addPage(page)
                try writeIndivVideoPages(forAlbum: album, usingFactory: factory, onContext: &context, backToPage: page)
            }
            print ("NOTICE:  Max Video id is currently \(maxVideoId) and Max Video Album id is \(maxAlbumId)")
            try writeRedirect(atPage: "/video-albums", to: "/vid", onContext: context)
        }
    }
    
    static func writeIndivVideoPages(forAlbum album: VideoAlbum, usingFactory factory: TsobHTMLFactory, onContext context: inout PublishingContext<Theskinny>, backToPage: Page) throws {
        for video in album.videos {
            var page = Page(path: "\(video.link)", content: Content())
            let html = HTML(.component(video.allByMyself(backToPage: backToPage)))
            page.content.body.html = html.render()
            context.addPage(page)
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
