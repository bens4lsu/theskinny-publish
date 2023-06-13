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
    
    var body: Component {
        EmptyComponent()
    }
}

struct VideoAlbum: Component, Decodable {
    let id: Int
    let name: String
    let caption: String
    let videos: [Video]
    
    var body: Component {
        EmptyComponent()
    }
}
