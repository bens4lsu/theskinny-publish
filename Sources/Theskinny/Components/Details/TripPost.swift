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
    let backToPage: Page? = nil
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
    
    var postShortBox: Plot.Component {
        switch _postType {
        case .blogPost(let blogPost):
            blogPost.postShortBox
        case .video(let video):
            video
        }
    }
    
    var body: Plot.Component {
        switch _postType {
        case .blogPost(let blogPost):
            blogPost
        case .video(let video):
            video.allByMyself(backToPage: nil)
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
        List(items) { $0 }.listStyle(.listAsDivs)
    }
}
