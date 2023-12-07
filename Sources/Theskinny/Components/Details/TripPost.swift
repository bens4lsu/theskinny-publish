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
    }
    
    private let _postType: PostType
    let backToPage: Page = Page(path: "/big-trip", content: Content())
    let nextPage: Page? = nil
    let prevPage: Page? = nil
    
    init(_ postType: PostType) {
        self._postType = postType
    }
 
    private var date: Date {
        switch _postType {
        case .blogPost(let blogPost):
            blogPost.date
        case .video(let video):
            video.dateRecorded ?? Date(timeIntervalSince1970: 0)
        }
    }
    
    private var mirrorUrl: String {
        switch _postType {
        case .blogPost(let blogPost):
            return "https://bigtrip.sailvelvetelvis.com/posts/" + blogPost.slug
        case .video(let video):
            return "https://bigtrip.sailvelvetelvis.com/video/" + video.autoSlug
        }
    }
    
    private var img: String {
        switch _postType {
        case .blogPost(let blogPost):
            if blogPost.ogImg == nil {
                return EnvironmentKey.emptyImg
            }
            return "/img/bigtrip/" + blogPost.ogImg!
        case .video(let video):
            return "/img/video-thumbnails/" + video.tn
        }
    }
    
    
    private var linkToFull: String {
        // used by the link on the home page
        switch _postType {
        case .blogPost(let blogPost):
            "/big-trip/\(blogPost.slug)"
        case .video(let video):
            video.autoSlug
        }
    }
    
    private var title: String {
        // used by the link on the home page
        switch _postType {
        case .blogPost(let blogPost):
            blogPost.title
        case .video(let video):
            video.name
        }
    }
    
    // MARK: Components
    
    var postHomePageLook: Component {
        return Div {
            Div { H4 { Link(title, url:linkToFull) } }
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
        }
    }
    

    
    var body: Plot.Component {
        switch _postType {
        case .blogPost(var blogPost):
            blogPost.injectedComponent = TripMirror(mirrorUrl)
            return blogPost
        case .video(let video):
            return video.allByMyself(backToPage: nil, injectedComponent: TripMirror(mirrorUrl))
        }
    }
}

extension TripPost: Comparable {
    static func < (lhs: TripPost, rhs: TripPost) -> Bool {
        lhs.date < rhs.date
    }
    
    static func == (lhs: TripPost, rhs: TripPost) -> Bool {
        lhs.date == rhs.date
    }
}




