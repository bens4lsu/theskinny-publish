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
    
    enum MenuLayoutScreen {
        case narrow
        case medium
        case full
    }
    
    private var listItemHome: ListItem {
        ListItem {
            Link("Home", url: "/")
        }
    }
    
    private var listItemDailyPhotos: ListItem {
        ListItem {
            Link ("Daily photos", url: "/dailyphoto")
        }
    }
    
    private var listItemGalleries: ListItem {
        ListItem {
            Link ("Photo collections", url: "/pgHome")
        }
    }
    
    
    var body: Component {

        Div {
            List {
                listItemHome
                Collapser(text: "Photo Galleries", elementId: "collapser-photos", name: "#3").component {
                    listItemDailyPhotos.class("li-pagelink")
                    listItemGalleries.class("li-pagelink")
                }
                Collapser(text: "Extras", elementId: "collapser-others", name: "#f").component {
                    ListItem {
                        Link("The Bald Page", url: "/x/bald")
                    }.class("li-pagelink")
                    ListItem {
                        Link("Quote File", url: "/x/quotefile")
                    }.class("li-pagelink")
                    ListItem {
                        Link("Shit John Said", url: "/x/shitjohnsaid")
                    }.class("li-pagelink")
                    ListItem {
                        Link("Dog Door Guide", url: "/x/speciesGuide")
                    }.class("li-pagelink")
                }
                Collapser(text: "From Others", elementId: "collapser-others", name: "#e").component {
                    ListItem {
                        Link("Tyler's Haikus", url: "/haikus")
                    }.class("li-pagelink")
                    ListItem {
                        Link("NJ Dispatch", url: "/njdispatches")
                    }.class("li-pagelink")
                    ListItem {
                        Link("Sarah's Resignation", url: "/x/sarahResignation")
                    }.class("li-pagelink")
                }
            }.class("fullScreenMenu")
            
            List {
                listItemHome
                listItemDailyPhotos
                listItemGalleries
                ListItem {
                    Link("Other pages", url: "/mobileSitemap")
                }
            }.class("mobileMenu")
            
            
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


