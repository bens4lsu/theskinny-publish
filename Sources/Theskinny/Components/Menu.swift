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
                        Link("Tag List", url: "/tags")
                    }.class("li-pagelink")
                }
                Collapser(text: "Photo Galleries", elementId: "collapser-photos").component {
                    listItemDailyPhotos.class("li-pagelink")
                    listItemGalleries.class("li-pagelink")
                }
                Collapser(text: "Videos", elementId: "collapser-videos").component {
                    ListItem {
                        Link("Family Vids", url: "/vid/family-home-videos/")
                    }.class("li-pagelink")
                    ListItem {
                        Link("Interesting/Other", url: "/vid/interesting-unusual-and-funny")
                    }.class("li-pagelink")
                }
                listItemAdop.class("li-pagelink")
                Collapser(text: "Velvet Elvi", elementId: "velvet-elvi").component {
                    ListItem {
                        Link("Rhodes 22 2000-2016", url: "/velvet-elvis/rhodes-22")
                    }.class("li-pagelink")
                    ListItem{
                        Link("Beneteau 2016-2023", url: "/velvet-elvis/beneteau")
                    }.class("li-pagelink")
                }
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
                ListItem {
                    Link("Videos", url: "/vid")
                }
                listItemAdop
                ListItem {
                    Link("Other pages", url: "/mobileSitemap")
                }
                ListItem {
                    Link("Benny's Posts", url: "https://mastodon.social/@bens4lsu").attribute(named: "target", value: "_blank")
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


