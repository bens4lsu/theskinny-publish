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
    
    private var listItemBlog: ListItem {
        ListItem {
            Link ("Current Page", url: "/blog/current")
        }
    }
    
    private var listItemAdop: ListItem {
        ListItem {
            Link ("Adopting the Kids", url: "/adop")
        }
    }
    
    
    var body: Component {

        Div {
            List {
                listItemHome.class("li-pagelink")
                Collapser(text: "Blog", elementId: "collapser-blog").component {
                    listItemBlog.class("li-pagelink")
                    ListItem {
                        Link("Index by Date", url: "/blog/blogArchiveByDate")
                    }.class("li-pagelink")
                    ListItem {
                        Text("tag/category index")
                    }.class("li-pagelink todo")
                }
                Collapser(text: "Photo Galleries", elementId: "collapser-photos").component {
                    listItemDailyPhotos.class("li-pagelink")
                    listItemGalleries.class("li-pagelink")
                }
                ListItem {
                    Text("Videos")
                }.class("todo")
                listItemAdop.class("li-pagelink")
                ListItem {
                    Text("Velvet Elvis")
                }.class("todo")
                ListItem {
                    Text("Playlists ♪")
                }.class("todo")
                
                Collapser(text: "Extras", elementId: "collapser-extras").component {
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
                    ListItem {
                        Link("Crystal On Oprah", url: "/x/crystalOnOprah")
                    }.class("li-pagelink")
                }
                Collapser(text: "From Others", elementId: "collapser-others").component {
                    ListItem {
                        Link("Tyler's Haikus", url: "/haikus")
                    }.class("li-pagelink")
                    ListItem {
                        Link("NJ Dispatch", url: "/njdispatches")
                    }.class("li-pagelink")
                    ListItem {
                        Link("Sarah's Resignation", url: "/x/sarahResignation")
                    }.class("li-pagelink")
                    ListItem {
                        Link("Madonna/Esther", url: "/x/madonnaEsther")
                    }.class("li-pagelink todo")
                    ListItem {
                        Link("On Michael Jackson", url: "/x/michaelJackson")
                    }.class("li-pagelink todo")
                    ListItem {
                        Link("Daisy On Honor", url: "/x/daisyOnHonor")
                    }.class("li-pagelink todo")
                }
            }.class("fullScreenMenu")
            
            List {
                listItemHome
                listItemBlog
                listItemDailyPhotos
                listItemGalleries
                listItemAdop
                ListItem {
                    Link("Other pages", url: "/mobileSitemap")
                }
            }.class("mobileMenu")
            
            
        }.class("menu")
    }
    
    private struct Collapser {
        var text: String
        var elementId: String
        //var name: String
        
        func component(@ComponentBuilder inside: @escaping ()-> Component) -> Component {
            ListItem {
                List {
                    Link(url: "javascript:void(0);") {
                        Text(text)
                        Span(" ▶︎").class("span-collapser").id("span-collapser-\(elementId)")
                        inside()
                    }
                }.class("menu-collapser")
            }
        }
        
    }
}


