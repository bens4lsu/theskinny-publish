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
    
    static func tsobAside<T: Website>(for context: PublishingContext<T>) -> Node {
        .aside(.class("side"),
               .div(.class("topleft")),
               .tsobMenu(for: context)
        )
    }
}
