//
//  File.swift
//  Theskinny
//
//  Created by Ben Schultz on 2025-03-12.
//

import Foundation
import Plot
import Publish

struct ElsewherePage: Component {
        
    var body: Component {
        Div {
            Text("Links to Ben's work, socials, etc...")
            List {
                Menu().elsewhere
            }.class("fullScreenMenu")
        }.class("mobileSitemap")
    }
}
