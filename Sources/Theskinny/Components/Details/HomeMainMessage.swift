//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/25/23.
//

import Foundation
import Publish
import Plot
import Files

struct HomeMainMessage: Component {
    
    var context: PublishingContext<Theskinny>
    
    var content: Component  {
        let path =  context.site.path(for: .home).parent + "Content-custom/homeMain.md"
        
        let file = try? File(path: path)
        let string = (try? file?.readAsString()) ?? ""
        return ComponentGroup {
            Markdown(string)
            self.cust
        }
    }
    
    var cust: Component {
        
//        let vgLink1 = VideoGalleryLink(url: "/video/lsubaton-rouge-lakes-are-a-disaster-right-now/", image: "mq20231028.jpg", caption: "LSU Lakes Are a Disaster Right Now")
//        let vgLink2 = VideoGalleryLink(url: "/video/sail-plan-route/", image: "mq20231028b.jpg", caption: "2024 Velvet Elvis Sail Plan")
//        let vgSet1 = VideoGalleryLinkSet(links: [vgLink1, vgLink2])
//        
//        return ComponentGroup {
//            H2("New Photo Gallery Posted...")
//            ImageGalleryLinkSet(181)
//            //H2("And Also A Couple Of Quick Videos To Watch...")
//            //VideoGalleryLinkSet(links: [vgLink1, vgLink2])
//        }
//        

        EmptyComponent()
    }
    
    init(_ context: PublishingContext<Theskinny>) {
        self.context = context
    }
    
    var body: Component {
        Div {
            content
        }.class("div-home-main-mess")
    }
}
