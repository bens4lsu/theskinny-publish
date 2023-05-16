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
    static func tsobFooter<T: Website>(for site: T) -> Node {
            let currentYear = Calendar.current.component(.year, from: Date())
            
            return
                .footer(
                    .class("main-footer"),
                    .div(
                        .text("© 2004 - \(currentYear) \(site.name)")
                    ),
                    .div(
                        .text("Generated using "),
                        .a(
                            .text("Publish"),
                            .href("https://github.com/johnsundell/publish")
                        ),
                        .text(". Written in Swift")
                    )
            )
        }
}
