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
    let currentYear = Calendar.current.component(.year, from: Date())
    
    var body: Component {
        Footer{
            Div {
                Text("© 2004 - \(currentYear) \(site.name)")
            }
            Div {
                Text("Generated using ")
                Link("Publish", url: "https://github.com/johnsundell/publish")
                Text(".  Written in Swift")
            }
        }
    }
}
