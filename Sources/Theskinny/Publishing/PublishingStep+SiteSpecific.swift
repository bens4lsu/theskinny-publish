//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/24/23.
//

import Foundation
import Plot
import Publish
import Files

extension PublishingStep where Site == Theskinny {
    
    static func writePostPages() -> Self {
        .step(named: "Write Post Summary Pages") { context in
            let allPosts = context.allBlogPostsReversed.items
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
            let allPosts = context.allBlogPostsReversed.items 
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
            for var album in VideoData.videoAlbums {
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
            try writeRedirect(atPage: "/video-albums/index.html", to: "/vid", onContext: &context)
        }
    }
    
    static func writeIndivVideoPages(forAlbum album: VideoAlbum, usingFactory factory: TsobHTMLFactory, onContext context: inout PublishingContext<Theskinny>, backToPage: Page) throws {
        for video in album.videos {
            let bigTripAlbumIds = VideoData.bigtripVideos.map { $0.id }
            let bigTripHtml: Bool = bigTripAlbumIds.contains(video.id)
            
            var page = Page(path: "\(video.link)", content: Content())
            
            let html: HTML = {
                switch bigTripHtml {
                case true:
                    return HTML(.component(TripPost(.video(video))))
                case false:
                    return HTML(.component(video.allByMyself(backToPage: backToPage)))
                }
            }()
            
            page.content.body.html = html.render()
            context.addPage(page)
        }
    }
    
    static func writeRedirect(atPage pagePath: Path, to redirPath: Path, onContext context: inout PublishingContext<Theskinny>) throws {
        //var page = Page(path: pagePath, content: Content())
        let redirScript = Script("window.location.replace(\"\(redirPath.string)\")")
        let redirHtml = HTML(redirScript.convertToNode())
        let file = try context.createOutputFile(at: pagePath)
        try file.write(redirHtml.render())
    }
    
    static func imageGalleries() -> Self {
        .step(named: "Image galleries"){ context in
            for gallery in ImageGalleryData.imageGalleries {
                var page = Page (path: Path(gallery.path), content: Content())
                let html = HTML(.component(gallery))
                page.content.imagePath = Path(gallery.normalImagePath)
                page.content.body.html = html.render()
                context.addPage(page)
            }
        }
    }
    
    static func dailyPhotos() throws -> Self {
        .step(named: "Daily Photos") { context in
            
            //redirect for /dailyphoto
            let script = DailyPhotoData.scriptRedirect
            let html = HTML(.component(Script(script)))
            var page = Page(path: Path("/dailyphoto"), content: Content())
            page.content.body.html = html.render().replacingOccurrences(of: "&lt;", with: "<")

            context.addPage(page)
            
            //script file for image on home page
            let scriptI = DailyPhotoData.scriptImage
            let scriptIFileName = "./scripts/dailyphotoimgage.js"
            let file = try context.createOutputFile(at: Path(scriptIFileName))
            try file.write(scriptI)
            
            for year in DailyPhotoData.years {
                
                // page for dailyphoto/20xx/index.html
                let yearLink = year.link
                if let firstPageOfYear = year.first?.link {
                    try writeRedirect(atPage: Path(yearLink), to: Path(firstPageOfYear), onContext: &context)
                }
                
                // individual image pages
                for dailyphoto in year.dp {
                    var page = Page(path: Path(dailyphoto.link), content: Content())
                    let html = HTML(.component(dailyphoto))
                    page.content.body.html = html.render()
                    page.imagePath = Path(dailyphoto.imagePath)
                    context.addPage(page)
                }
            }
        }
    }
    
    
    static func oldMicroPosts() throws ->Self {
        .step(named: "Old Micro Posts") { context in
            for (year, posts) in MicroPostData.postsByYear {
                let url = "/micro-posts/\(year)"
                let urlRev = url + "/reversed"
                
                let mposts = MicroPosts(mposts: posts, allYears: MicroPostData.years, year: year)
                
                var page = Page (path: Path(url), content: Content())
                let html = HTML(.component(mposts.bodySorted(url: urlRev, direction: > )))  //revUrl here because that gets used to generate the link to the reversed page
                page.content.body.html = html.render()
                context.addPage(page)
                
                var pageRev = Page (path: Path(urlRev), content: Content())
                let htmlRev = HTML(.component(mposts.bodySorted(url: url, direction: < ))) //url here because that gets used to generate the link to the default page
                pageRev.content.body.html = htmlRev.render()
                context.addPage(pageRev)
            }
        }
    }
}
