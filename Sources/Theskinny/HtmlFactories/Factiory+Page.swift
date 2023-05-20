//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/18/23.
//

import Foundation
import Plot
import Publish

extension TsobHTMLFactory {
    func makePageHTML(for page: Publish.Page, context: Publish.PublishingContext<Theskinny>) throws -> Plot.HTML {
        var pageTitle: String {
            switch page.path.string {
            case "pgHome":
                return "Daily photos on theskinnyonbenny.com"
            default:
                return "theskinnyonbenny.com"
            }
        }
        
        
        let htmlHeadInfo = HeaderInfo(location: context.index, title: pageTitle)
        let pageContent = Article { page.body }
        
        let pageMain = AnyPageMain(mainContent: pageContent, site: context.site)

        return HTML(
            htmlHeadInfo.node,
            .body(.component(pageMain))
        )
    }
    
    
}
