//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/19/23.
//

import Foundation
import Plot
import Publish

struct LayoutFooter: Component {
    var site: any Website
    
    var body: Component {
        Footer{
            Div {
                Div {
                    Text("© 2004 - \(EnvironmentKey.currentYear) \(site.name)")
                }
                Div {
                    Text("Generated using ")
                    Link("Publish", url: "https://github.com/johnsundell/publish")
                    Text(".  Written in Swift.")
                }
            }.class("footer-text")
        }.class("main-footer")
    }
}
