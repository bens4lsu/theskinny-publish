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
    
    static func redirect(to path: String) -> Node {
        .script(.text("window.location.href = \"\(path)\""))
    }
}


