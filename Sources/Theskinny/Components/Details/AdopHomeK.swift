//
//  File.swift
//
//
//  Created by Ben Schultz on 5/27/23.
//

import Foundation
import Publish
import Plot
import Files


struct AdopHomeK: Component {
    
    var context: PublishingContext<Theskinny>
    
    var content: Component  {
        let path =  context.site.path(for: .home).parent() + "Content-page-parts/adopHomeK.md"
        
        let file = try? File(path: path)
        let string = (try? file?.readAsString()) ?? ""
        return Markdown(string)
    }
    
    
    init(_ context: PublishingContext<Theskinny>) {
        self.context = context
    }
    
    var body: Component {
        Div {
            content
        }.class("div-adop-k")
    }
}
