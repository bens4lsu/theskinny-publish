//
//  File.swift
//  
//
//  Created by Ben Schultz on 2023-12-07.
//

import Foundation
import Plot
import Publish

struct TripMirror: Component {
    let url: String
    
    init (_ url: String) {
        self.url = url
    }
    
    var body: Component {
        Div {
            Text("This page mirrored at ")
            Link(url, url: url)
            Text(" in case you want to share without the baggage of sharing the fact that you know about theskinnyonbenny")
        }.class("div-mirror")
    }
}
