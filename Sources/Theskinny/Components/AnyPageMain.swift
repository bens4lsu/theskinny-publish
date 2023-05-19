//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/19/23.
//

import Foundation
import Plot
import Publish

struct AnyPageMain: Component {
    
    var mainContent: Component
    var site: any Website
    
    var body: Component {
        Div {
            LayoutHeader()
            LayoutAside()
            mainContent.class("content")
            LayoutFooter(site: site)
        }.class("wrapper")
        
    }
    
}
