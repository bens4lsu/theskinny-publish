//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/15/23.
//  updated for actual site 5/16/23

import Foundation
import Publish
import Plot

extension Node where Context == HTML.BodyContext {
    static func wrapper(_ nodes: Node...) -> Node {
        .div(.class("wrapper"), .group(nodes))
    }
}
