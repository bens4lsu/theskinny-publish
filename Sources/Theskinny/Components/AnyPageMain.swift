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
    var custPersonImageClass: String?
    var custHeaderClass: String?
    
    var debug = false
    
    var body: Component {
        //if debug { print (mainContent.render(indentedBy: .tabs(1))) }
        return Div {
            LayoutHeader(custHeaderClass: custHeaderClass)
            LayoutAside(custPersonImageClass: custPersonImageClass)
            mainContent.class("content")
            LayoutFooter(site: site)
        }.class("wrapper")
        
    }
    
}
