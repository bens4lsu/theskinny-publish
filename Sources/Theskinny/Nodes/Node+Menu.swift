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
    
    static func tsobMenu<T: Website>(for context: PublishingContext<T>) -> Node {
        .div(.class("menu"),
             .ul(.li(.text("Item 1")),
                 .li(.text("Item 2")),
                 .li(.text("Item 3"))
             )
        )
    }
}
