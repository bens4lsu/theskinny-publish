//
//  File.swift
//  
//
//  Created by Ben Schultz on 2023-09-14.
//

import Foundation
import Plot
import Publish

struct MicroPost: Component, Decodable {
    
    
    enum PostSource: String, Decodable {
        case mastodon
        case twitter
        
        var platoformImage: String {
            switch self {
            case .mastodon:
                return "/img/micro/mastodon-logo.png"
            case .twitter:
                return "/img/micro/twitter-bird.png"
            }
        }
    }
    
    var date: Date
    var source: PostSource
    var sourceUrl: String
    var content: String
    var media: String?
    
    var dateString: String {
        date.formatted(date: .abbreviated, time: .shortened)
    }
    
    
    var body: Component {
        Div {
            Div {
                Div {
                    Image("/img/micro/bennyst.png")
                }.class("micro-post-icon-top")
                Div {
                    Image(source.platoformImage)
                }.class("micro-post-icon-bottom")
            }.class("micro-post-icons")
            Div {
                Div(Markdown(content)).class("micro-post-content")
                Div(Markdown(media ?? "")).class("micro-post-media")
                Div {
                    Link(dateString, url: sourceUrl).linkTarget(.blank)
                }
            }
        }.class("micro-post-container")
    }
}

extension MicroPost: Comparable {
    
    static func < (lhs: MicroPost, rhs: MicroPost) -> Bool {
        lhs.date < rhs.date
    }
    
}
