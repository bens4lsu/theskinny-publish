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
                ListItem {
                    Link("Home", url: "/")
                }
                Collapser(text: "Photo Galleries", elementId: "collapser-photos", name: "#3").component {
                    ListItem {
                        Link ("Daily photos", url: "/dailyphoto")
                    }.class("li-pagelink")
                    ListItem {
                        Link ("Photo collections", url: "/pgHome")
                    }.class("li-pagelink")
                }
                Collapser(text: "From Others", elementId: "collapser-others", name: "#e").component {
                    ListItem {
                        Link("Tyler's Haikus", url: "/haikus")
                    }.class("li-pagelink li-fullscreenonly")
                    ListItem {
                        Link("NJ Dispatch", url: "/njdispatches")
                    }.class("li-pagelink li-fullscreenonly")
                }
                ListItem {
                    Link("Others", url: "/mobileMenu")
                }.class("li-mobileonly")
            }
        }.class("menu")
    }
    
    private struct Collapser {
        var text: String
        var elementId: String
        var name: String
        
        func component(@ComponentBuilder inside: @escaping ()-> Component) -> Component {
            ListItem {
                List {
                    Link(url: name) {
                        Text(text)
                        Span(" ▶︎").class("span-collapser").id("span-collapser-\(elementId)")
                        inside()
                    }
                }.class("menu-collapser")
            }
        }
        
    }
}


