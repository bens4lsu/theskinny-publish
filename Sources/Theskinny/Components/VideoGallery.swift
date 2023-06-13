//
//  File.swift
//  
//
//  Created by Ben Schultz on 6/11/23.
//

import Foundation
import Plot
import Publish

struct Video: Component, Decodable {
    let id: Int
    let name: String
    let dateRecorded: Date?
    let caption: String
    let url: String
    let embed: String
    
    private var dateRecordedComponent: Component {
        if dateRecorded == nil {
            return EmptyComponent()
        }
        let formatter = EnvironmentKey.defaultDateFormatter
        return Text(formatter.string(from: dateRecorded!))
    }
    
    var body: Component {
        Div {
            H2(name)
            Text(caption)
            dateRecordedComponent
        }
    }
}

struct VideoAlbum: Component, Decodable {
    let id: Int
    let name: String
    let caption: String
    let slug: String
    var videos: [Video]
    
    var body: Component {
        Div {
            H1(name)
            Div(caption)
            List(videos) { video in
                video
            }
        }
    }
    
    var singleLine: Component {
        Div {
            Div {
                H2(name)
                Span(caption)
            }
            Div("thumbnail")
        }
    }
}

struct VideoAlbumIndex: Component {
    var videoAlbums: [VideoAlbum]
    var title: String
    
    var body: Component {
        Div {
            H1(title)
            List(videoAlbums) { $0.singleLine }
        }
    }
}
