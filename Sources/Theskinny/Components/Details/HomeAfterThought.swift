//
//  File.swift
//  Theskinny
//
//  Created by Ben Schultz on 2024-10-19.
//


import Foundation
import Publish
import Plot
import Files

struct HomeAfterThought: Component {
    
    var context: PublishingContext<Theskinny>
    
    var content: Component  {
        let path =  context.site.path(for: .home).parent + "Content-custom/homeAfter.md"
        
        let file = try? File(path: path)
        let string = (try? file?.readAsString()) ?? ""
        return ComponentGroup {
            Markdown(string)
            self.cust
        }
    }
    
    var cust: Component {
        
        // Photo Gallery
                
        //       ComponentGroup {
        //           Text("Nothing big here, just a few pics from the Christmas season.")
        //           ImageGalleryLinkSet(196)
        //           EmptyComponent()
        //       }



        // Video Galleries
                
              let vgLink1 = VideoGalleryLink(url: "/video/maks-drinks-water-funny/", image: "mq20240124.jpg", caption: "Maks Drinks Water Funny")
        //        let vgLink2 = VideoGalleryLink(url: "/video/sail-plan-route/", image: "mq20231028b.jpg", caption: "2024 Velvet Elvis Sail Plan")
               
               return ComponentGroup {

                   H2("A Short Nonsense Video")
                   VideoGalleryLinkSet(links: [vgLink1])
                   H2("Wedding and Monster Snow Pics")
                   ImageGalleryLinkSet(196)
               }
        //



        // Nothing
        //        EmptyComponent()
        
        


    }
    
    init(_ context: PublishingContext<Theskinny>) {
        self.context = context
    }
    
    var body: Component {
        Div {
            
            // Link to Online, interactive map
            Div {
                Div {
                    Div {
                        H2{
                            Link("Online, Interactive Map Review", url: "./velvet-elvis/pegasus/log")
                        }

                        Div("Yet another page for the Velvet Elvis enthusiasts.  This is an interactive look at all of the places we've logged.")
                    }.class("divPostStuff")
                    Div {
                        Image("/img/video-thumbnails/ve-log-tn.jpg")
                    }
                }.class("divPostFlexbox")
                TopNavLinks(rightLinkInfo: LinkInfo(text: "interact with the map yourself", url: "./velvet-elvis/pegasus/log")).class("divPostEndLink")
            }.class("divPostShort")
            
        }.class("div-home-after")
    }
}
