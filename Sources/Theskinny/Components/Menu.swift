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
                Collapser(text: "Photo Galleries", elementId: "xxx", name: "#3").component {
                    ListItem {
                        Link ("Daily photos", url: "/dailyphoto")
                    }
                    ListItem {
                        Link ("Photo collections", url: "/pgHome")
                    }
                }
                Collapser(text: "From Others", elementId: "rowCt", name: "#e").component {
                    ListItem {
                        Link("Tyler's Haikus", url: "/haikus")
                    }
                    ListItem {
                        Link("NJ Dispatch", url: "/njdispatches")
                    }
                }
            }
        }.class("menu")
    }
    
    private struct Collapser {
        var text: String
        var elementId: String
        var name: String
        
        func component(@ComponentBuilder inside: @escaping ()-> Component) -> Component {
            ListItem {
                //<a class="sbtop" href="javascript:showHide(document.getElementById('rowCt'), document.getElementById('imgStandardCt'));" name="#e">From Others </a>
                Link(text, url: "javascript:showHide(document.getElementById('\(elementId)', document.getElementById('imgStandardCt'));").attribute(named: "name", value: name)
                List {
                    inside()
                }
            }
        }
        
    }
    
}


