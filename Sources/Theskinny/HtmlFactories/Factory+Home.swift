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
        let htmlHeadInfo = HeaderInfo(location: context.index, title: "theskinnyonbenny.com")
        let pageContent = HomePage()
        let pageMain = AnyPageMain(mainContent: pageContent, site: context.site)

        return HTML(
            htmlHeadInfo.node,
            .body(.component(pageMain))
        )
    }
}
