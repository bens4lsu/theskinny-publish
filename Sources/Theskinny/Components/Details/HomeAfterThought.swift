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
            //content
        }.class("div-home-after")
    }
}
