//
//  File.swift
//  
//
//  Created by Ben Schultz on 6/21/23.
//

import Foundation
import Plot
import Publish

struct VideoAlbum: Component, Decodable {
        
    let id: Int
    let name: String
    let caption: String
    let slug: String
    var videos: [Video]
    let tn: String?
    let linkBack: LinkInfo?
    
    var link: String {
        "/video-albums/\(slug)"
    }
    
    var totalDuration: TimeInterval {
        videos.reduce(0) { $0 + $1.duration }
    }
    
    var formattedDuration: String {
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        if totalDuration >= 3600 {
            formatter.allowedUnits = [.hour, .minute, .second];
        } else {
            formatter.allowedUnits = [.minute, .second];
        }
        guard let durationString = formatter.string(from: totalDuration)
        else {
            return ""
        }
        return "Duration:  \(durationString)"
    }
    
    var minDate: Date? {
        videos
            .filter { $0.dateRecorded != nil }
            .sorted()
            .first?
            .dateRecorded
    }
    
    
    var body: Component {
        Div {
            TopNavLinks(linkBack, nil, nil)
            H1(name)
            Div {
                Text(caption)
            }.class("vid-gal-top-text")
            List(videos.sorted().reversed()) { $0 }.listStyle(.listAsDivs)
        }
    }
    
    
    // This is the component used on the listing of video galleries.  eg /vid/family-home-videos
    var singleLine: Component {
        Div {
            Div {
                H2 { Link(name, url: link) }
                Div { Markdown(caption) }
                H3 { Text("\(videos.count) videos") }
                H3 { Text("Total Duration: \(formattedDuration)") }
            }.class("vid-gal-stuff")
            Div{
                Link(url: link) {
                    Image("/img/video-thumbnails/\(tn ?? "")")
                }
            }.class("vid-gal-thumbnail")
        }.class("vid-gal-line-item")
    }
}

extension VideoAlbum: Comparable {
    static func < (lhs: VideoAlbum, rhs: VideoAlbum) -> Bool {
        if lhs.minDate != nil && rhs.minDate != nil {
            return lhs.minDate! < rhs.minDate!
        }
        return lhs.id < rhs.id
    }
    
    static func == (lhs: VideoAlbum, rhs: VideoAlbum) -> Bool {
        lhs.id == rhs.id
    }
    
    
}
