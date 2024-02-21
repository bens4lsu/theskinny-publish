//
//  File.swift
//  
//
//  Created by Ben Schultz on 2023-11-29.
//

import Foundation
import Plot
import Publish

struct TripPost: Component {
    
    enum PostType {
        case blogPost(BlogPost)
        case video(Video)
        case pg(Gallery)
    }
    
    private let _postType: PostType
//    let backToPage = LinkInfo("Big Trip Index", "/big-trip")
//    var nextPage: LinkInfo? = nil
//    var prevPage: LinkInfo? = nil
    
    init(_ postType: PostType) {
        self._postType = postType
    }
 
    private var date: Date {
        switch _postType {
        case .blogPost(let blogPost):
            blogPost.date
        case .video(let video):
            video.dateRecorded ?? Date(timeIntervalSince1970: 0)
        case .pg(let gallery):
            gallery.date ?? EnvironmentKey.yyyyMMddDateFormatter.date(from: "2000-01-01")!
        }
    }
    
    private var formattedDate: String {
        return EnvironmentKey.defaultDateFormatter.string(from: date)
    }
    
    private var mirrorUrl: String {
        switch _postType {
        case .blogPost(let blogPost):
            return "https://bigtrip.sailvelvetelvis.com/posts/" + blogPost.slug
        case .video(let video):
            return "https://bigtrip.sailvelvetelvis.com/video/" + video.autoSlug
        case .pg(_):
            return ""
        }
        
    }
    
    private var img: String {
        switch _postType {
        case .blogPost(let blogPost):
            return blogPost.ogImg ?? EnvironmentKey.emptyImg
        case .video(let video):
            return "/img/video-thumbnails/" + video.tn
        case .pg(let gallery):
            return gallery.normalImagePath
        }
    }
    
    
    var linkToFull: String {
        // used by the link on the home page
        switch _postType {
        case .blogPost(let blogPost):
            "/big-trip/\(blogPost.slug)"
        case .video(let video):
            "/video/\(video.autoSlug)"
        case .pg(let gallery):
            gallery.path
        }
    }
    
    var title: String {
        // used by the link on the home page
        switch _postType {
        case .blogPost(let blogPost):
            blogPost.title
        case .video(let video):
            "Video: " + video.name
        case .pg(let gallery):
            "Photo Gallery: " + gallery.name
        }
    }
    
    // MARK: Components
    
    var postHomePageLook: Component {
        return Div {
            Div { 
                H4 { Link(title, url:linkToFull) }
                Span(formattedDate).class("caption")
            }
            Div { Image(img) }
        }.class ("divH4Sub")
    }
    
    
    var postShortBox: Plot.Component {
        switch _postType {
        case .blogPost(var blogPost):
            blogPost.linkToFull = "/big-trip/\(blogPost.slug)"
            return blogPost.postShortBox
        case .video(var video):
            video.title = "Video: " + video.name
            return video
        case .pg(var gallery):
            gallery.name = "Photo Gallery: " + gallery.name
            return gallery.postShortBox
        }
    }
    
    var body: Component {
        switch _postType {
        case .blogPost(var blogPost):
            blogPost.injectedComponent = TripMirror(mirrorUrl)
            return blogPost
        case .video(let video):
            return video.allByMyself(backToPage: nil, injectedComponent: TripMirror(mirrorUrl))
        case .pg(_):
            return EmptyComponent()
        }
    }
    
//    var body: Plot.Component {
//        ComponentGroup {
//            TopNavLinks(prevPage, backToPage, nextPage)
//            bodyContent
//        }
//    }
    
}

extension TripPost: Comparable {
    static func < (lhs: TripPost, rhs: TripPost) -> Bool {
        lhs.date < rhs.date
    }
    
    static func == (lhs: TripPost, rhs: TripPost) -> Bool {
        lhs.date == rhs.date
    }
}




