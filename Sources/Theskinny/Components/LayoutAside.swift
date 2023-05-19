//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/19/23.
//

import Foundation
import Plot
import Publish

struct LayoutAside: Component {
    
    var body: Component {
        Aside{
            Div { }.class("topleft")
            Menu()
        }.class("side")
    }
}
