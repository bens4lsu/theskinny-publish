//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/15/23.
//

import Foundation
import Publish
import Plot

extension Node where Context == HTML.BodyContext {
    static func postContent<T: Website>(for items: [Item<T>], on site: T) -> Node {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        
        let sortedItems = items.sorted { $0.date < $1.date }
        
        return .wrapper(
                .ul(.class("item-list"),
                .forEach(sortedItems) { item in
                    .li (
                        .article(
                            .h1(
                                .a(
                                    .href(item.path),
                                    .text(item.title)
                                )
                            ),
                            .tagList(for: item.tags, on: site),
                            .p(.text(item.description)),
                            .p(.text("Published: \(formatter.string(from: item.lastModified))"))
                        )
                    )
                }
            )
        )
    }
}
