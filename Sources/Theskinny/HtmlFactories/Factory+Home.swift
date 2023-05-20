//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/15/23.
//

import Foundation
import Publish
import Plot

extension TsobHTMLFactory {
    
    
    
    
    func makeHomeHTML<T: Website>(for index: Index, section: Section<T>, context: PublishingContext<T>) throws -> HTML {
        let location = context.index
        let headerInfo = HeaderInfo(location: location, title: "Home")
        return HTML(
            headerInfo.node,
            
            .body(.wrapper(
                .tsobHeader(for: context),
                .tsobArticle(for: context),
                .tsobAside(for: context),
                .tsobFooter(for: context.site)
            ))
        )
    }
}
