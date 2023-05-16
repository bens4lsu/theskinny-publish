//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/16/23.
//  updated for actual site 5/16/23

import Foundation
import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    
    static func tsobArticle<T: Website>(for context: PublishingContext<T>) -> Node {
        .article(.class("content"),
                 .h1(.text("Main article area")),
                 .p(.text("In this layout, we display the areas in source order for any screen less that 500 pixels wide. We go to a two column layout, and then to a three column layout by redefining the grid, and the placement of items on the grid."))
        )
    }
}
