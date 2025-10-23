//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/24/23.
//

import Foundation
import Plot
@preconcurrency import Publish
import Files

extension PublishingStep where Site == Theskinny {
    
    private static let serialQueue = DispatchQueue(label: "theskinnyonbenny.AsyncPublshing.serial")
    private static let concurrentQueue = DispatchQueue(label: "theskinnyonbenny.AsyncPublshing.concurrent", attributes: .concurrent)
    
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
                
                let description = "Blog posts from \(posts.dates.0) to \(posts.dates.1)"
                let _ = makeCompletePage(title: description,
                                         description: description,
                                         date: posts.dates.1,
                                         imagePath: "",
                                         content: posts.multiPostPageContent(withTopLinks: linkInfo),
                                         pagePath: "blog/\(pageName)", onContext: &context)
                
            }
            
            // redirect pages for /blog and /blog2
            for pathString in ["/blog", "/blog2"] {
                let description = "Blog on theskinnyonbenny.com (redirecting to latest)"
                let _ = makeCompletePage(title: description,
                                         description: description,
                                         date: Date(),
                                         imagePath: "",
                                         content: Script.redirectToBlogCurrent,
                                         pagePath: pathString,
                                         onContext: &context)
            }
        }
    }
    
    
    static func writeRedirectsFromWordpressUrls() throws -> Self {
        .step(named: "Write redirects for wordpress urls") { context in
            let allPosts = context.allBlogPostsReversed.items 
            for post in allPosts {
               try writeRedirect(atPage: "/blog2/archives/\(post.id)", to: "/blog2/\(post.slug)", onContext: &context)
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
                album.videos = album.videos.sorted()
                let albumMax = album.videos.map { $0.id }.max() ?? Int.min
                if albumMax > maxVideoId {
                    maxVideoId = albumMax
                }
                if album.id > maxAlbumId {
                    maxAlbumId = album.id
                }
                                
                let page = makeCompletePage(title: album.name,
                                 description: album.caption,
                                 date: (album.minDate ?? Date()),
                                 imagePath: (album.tn ?? ""),
                                            content: album,
                                 pagePath: "/video-albums/\(album.slug)",
                                 onContext: &context
                                 )
                
                try writeIndivVideoPages(forAlbum: album, usingFactory: factory, onContext: &context, backToPage: page)
            }
            print ("NOTICE:  Max Video id is currently \(maxVideoId) and Max Video Album id is \(maxAlbumId)")
            try writeRedirect(atPage: "/video-albums", to: "/vid", onContext: &context)
        }
    }
    
    static func writeIndivVideoPages(forAlbum album: VideoAlbum, usingFactory factory: TsobHTMLFactory, onContext context: inout PublishingContext<Theskinny>, backToPage: Page) throws {
        for video in album.videos {
            let bigTripAlbumIds = VideoData.bigtripVideos.map { $0.id }
            let bigTripHtml: Bool = bigTripAlbumIds.contains(video.id)
            
            let pageContentInside: Component = {
                switch bigTripHtml {
                case true:
                    return TripPost(.video(video))
                case false:
                    return video.allByMyself(backToPage: backToPage)
                }
            }()
            
            let _ = makeCompletePage(title: video.title,
                                        description: video.caption,
                                        date: (video.dateRecorded ?? Date()),
                                        imagePath: "/img/video-thumbnails/\(video.tn)",
                                        content: pageContentInside,
                                        pagePath: "\(video.link)",
                                        onContext: &context
                                    )
        }
    }
    
    static func writeRedirect(atPage pagePath: Path, to redirPath: Path, onContext context: inout PublishingContext<Theskinny>) throws {
        let attrib = Attribute<PublishingContext<Theskinny>>(name: "redirect", value: "true")

        let contentBody = Content.Body(){
            Script("window.location.replace(\"\(redirPath.string)\")").attribute(attrib)
        }
        
        let content = Publish.Content(title: "Redirecting...", description: "", body: contentBody, date: Date(), lastModified: Date(), imagePath: .init(""))
        let page = Page(path: pagePath, content: content)
        
        context.addPage(page)
    }
    
    static func imageGalleries() -> Self {
        .step(named: "Image galleries"){ context in
            for gallery in ImageGalleryData.imageGalleries {
                let _ = makeCompletePage(title: gallery.name,
                                         description: gallery.name,
                                         date: gallery.date,
                                         imagePath: gallery.normalImagePath,
                                         content: gallery,
                                         pagePath: gallery.path,
                                         onContext: &context
                                        )
            }
            // gal/index page
            let _ = makeCompletePage(title: "Photo Galleries on theskinnyonbenny.com",
                                     description: "Photo Galleries on theskinnyonbenny.com",
                                     date: Date(),
                                     imagePath: EnvironmentKey.emptyImg,
                                     content: Galleries(),
                                     pagePath: "/gal",
                                     onContext: &context
                                    )
        }
    }
    
    static func dailyPhotos() throws -> Self {
        .step(named: "Daily Photos") { context in

            //redirect for /dailyphoto
            let redirectScript = try Script(DailyPhotoData.scriptRedirect)
            let content = AnyPageMain(mainContent: redirectScript, site: context.site)  // need all the headers so that jquery loads and the script will run.
            let description = "Daily photo on theskinnyonbenny (redirecting to latest photo)."
            let _ = makeCompletePage(title: description,
                                     description: description,
                                     date: Date(),
                                     imagePath: EnvironmentKey.emptyImg,
                                     content: content,
                                     pagePath: "/dailyphoto",
                                     onContext: &context
                                    )

            
            
            for year in DailyPhotoData.years {
                // page for dailyphoto/20xx/index.html
                let yearLink = year.link
                if let firstPageOfYear = year.first?.link {
                    try writeRedirect(atPage: Path(yearLink), to: Path(firstPageOfYear), onContext: &context)
                }
                
                // individual image pages
                
            
                let pages = await withTaskGroup(of: Page.self, returning: [Page].self) { taskGroup in
                    for dailyphoto in year.dp {
                        taskGroup.addTask {
                            let cg = ComponentGroup {
                                dailyphoto
                                Script(DailyPhotoData.scriptCalendar)
                            }
                            let description = "Daily Photo for \(dailyphoto.dateString) on theskinnyonbenny.com"
                            let page = makeCompletePageAsync(title: description,
                                                             description: description,
                                                             date: dailyphoto.date,
                                                             imagePath: dailyphoto.imagePath,
                                                             content: cg,
                                                             pagePath: dailyphoto.link
                            )
                            return page
                        }
                    }
                    
                    var pages = [Page]()
                    for await result in taskGroup {
                        pages.append(result)
                    }
                    return pages
                }
                for page in pages {
                    context.addPage(page)
                }
            }
        }
    }
    
    
    static func oldMicroPosts() throws -> Self {
        .step(named: "Old Micro Posts") { context in
            for (year, posts) in MicroPostData.postsByYear {
                let url = "/micro-posts/\(year)"
                let urlRev = url + "/reversed"
                
                let mposts = MicroPosts(mposts: posts, allYears: MicroPostData.years, year: year)
                
                let _ = makeCompletePage(title: "Old Tweets",
                                         description: "Old Tweets",
                                         date: posts.first!.date,
                                         imagePath: EnvironmentKey.emptyImg,
                                         content: mposts.bodySorted(url: url, direction: < ),
                                         pagePath: url,
                                         onContext: &context
                                        )
                let _ = makeCompletePage(title: "Old Tweets",
                                         description: "Old Tweets",
                                         date: posts.first!.date,
                                         imagePath: EnvironmentKey.emptyImg,
                                         content: mposts.bodySorted(url: url, direction: < ),
                                         pagePath: urlRev,
                                         onContext: &context
                                        )
            }
        }
    }
    
    
    static func playlists() -> Self {
        .step(named: "Music Playlists") { context in
            for playlist in AppleMusicData.playlists {
                let _ = makeCompletePage(title: playlist.pageName,
                                         description: playlist.pageName,
                                         date: playlist.dateUpdated,
                                         imagePath: EnvironmentKey.emptyImg,
                                         content: playlist,
                                         pagePath: playlist.pageName,
                                         onContext: &context
                                        )
            }
            
            // redirect for /playlists
            try writeRedirect(atPage: "/playlist", to: "/playlist/RecentlyPlayed", onContext: &context)
        }
    }
    
    private static func makeCompletePageAsync(title: String, description: String, date: Date?, imagePath: String, content: Component, pagePath: String) -> Page {
        let contentBody = Content.Body(indentation: EnvironmentKey.defaultIndentation){
            content
        }
        let content = Publish.Content(title: title,
                                      description: description,
                                      body: contentBody,
                                      date: (date ?? Date()),
                                      lastModified: (date ?? Date()),
                                      imagePath: Path(imagePath))
        let page = Page(path: Path(pagePath), content: content)

        return page
    }
    
    private static func makeCompletePage(title: String, description: String, date: Date?, imagePath: String, content: Component, pagePath: String, onContext context: inout PublishingContext<Theskinny>) -> Page {
        let page = makeCompletePageAsync(title: title, description: description, date: date, imagePath: imagePath, content: content, pagePath: pagePath)
        context.addPage(page)
        return page
    }
    
    
}


