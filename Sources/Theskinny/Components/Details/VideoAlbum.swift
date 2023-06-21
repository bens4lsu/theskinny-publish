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
    
    var link: String {
        "/vid2/\(slug)"
    }
    
    var body: Component {
        Div {
            H1(name)
            List(videos) { $0 }.listStyle(.listAsDivs)
        }
    }
    
    
    // This is the component used on the listing of video galleries.  eg /vid/family-home-videos
    var singleLine: Component {
        Div {
            Div {
                H2 { Link(name, url: link) }
                Span(Markdown(caption))
            }
            Div{
                Link(url: link) {
                    Text("thumbnail")
                }
            }.class("vid-gal-thumbnail")
        }.class("vid-gal-line-item")
    }
}
