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
 
    var date: Date {
        switch _postType {
        case .blogPost(let blogPost):
            blogPost.date
        case .video(let video):
            video.dateRecorded ?? Date(timeIntervalSince1970: 0)
        }
    }
    
    var mirrorUrl: String {
        switch _postType {
        case .blogPost(let blogPost):
            return "https://bigtrip.sailvelvetelvis.com/posts/" + blogPost.slug
        case .video(let video):
            return "https://bigtrip.sailvelvetelvis.com/video/" + video.autoSlug
            
        }
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
    
    var bodyContent: Plot.Component {
        switch _postType {
        case .blogPost(let blogPost):
            return blogPost
        case .video(let video):
            return video.allByMyself(backToPage: nil)
        }
    }
    
    var body: Component {
        ComponentGroup {
            bodyContent
            TripMirror(mirrorUrl)
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

struct TripPosts: Component {
    let items: [TripPost]
    
    init(items: [TripPost]) {
        let sortedItems = items.sorted(by: < )
        self.items = sortedItems
    }
    
    var body: Component {
        Article {
            List(items) { $0.postShortBox }.listStyle(.listAsDivs)
        }.class("content")
    }
}

struct TripMirror: Component {
    let url: String
    
    init (_ url: String) {
        self.url = url
    }
    
    var body: Component {
        Div {
            Text("This page mirrored at ")
            Link(url, url: url)
            Text(" in case you want to share without the baggage of knowing about theskinnyonbenny")
        }.class("div-mirror")
    }
}
