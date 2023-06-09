//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/19/23.
//

import Foundation
import Plot
import Publish

struct LayoutHeader: Component {
    
    var custHeaderClass: String?
    
    var body: Component {
        Header{  }.class("main-head \(custHeaderClass ?? "")")
    }
}
