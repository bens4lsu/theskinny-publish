//
//  File.swift
//
//
//  Created by Ben Schultz on 7/9/23.
//

import Foundation
import Publish
import Plot

struct HomeMastodon: Component {
    
    var role: Attribute<Theskinny> { Attribute(name: "role", value: "feed") }
    
    var body: Component {
        Div {
            Div {
                H1("Links/Quick Thoughts")
                Div {
                    Div { }.class("loading-spinner")
                }.id("mt-body").class("mt-body").attribute(role)
            }.class("mt-timeline")
        }.class("div-home-tweets")
    }
}
