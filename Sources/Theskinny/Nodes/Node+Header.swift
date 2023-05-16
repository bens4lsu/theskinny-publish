//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/15/23.
//  updated for actual site 5/16/23

import Foundation
import Plot
import Publish

extension Node where Context == HTML.BodyContext {
    
    static func tsobHeader<T: Website>(for context: PublishingContext<T>) -> Node {
        .header(.class("main-head"))
    }
}
