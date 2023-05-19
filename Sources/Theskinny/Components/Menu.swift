//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/19/23.
//

import Foundation
import Plot
import Publish


struct Menu: Component {
    
    var body: Component {
        Div {
            List {
                ListItem("Item 1")
                ListItem("Item 2")
                ListItem("Item 3")
                ListItem {
                    Link("Tyler's Haikus", url: "/haikus") 
                }
            }
        }.class("menu")
    }
}
