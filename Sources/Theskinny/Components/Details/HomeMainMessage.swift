//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/25/23.
//

import Foundation
import Publish
import Plot
import Files

struct HomeMainMessage: Component {
    
    var context: PublishingContext<Theskinny>
    
    var content: Component  {
        let path =  context.site.path(for: .home).parent + "Content-customs/homeMain.md"
        
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
        }.class("div-home-main-mess")
    }
}
