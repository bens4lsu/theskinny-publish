//
//  File.swift
//  
//
//  Created by Ben Schultz on 6/11/23.
//

import Foundation
import Plot
import Publish


struct VideoAlbumIndex: Component {
    var videoAlbums: [VideoAlbum]
    var title: String
    
    var body: Component {
        Div {
            H1(title)
            List(videoAlbums) { $0.singleLine }.listStyle(.listAsDivs)
        }
    }
}
