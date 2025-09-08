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
    
    init(_ context: PublishingContext<Theskinny>) {
        self.context = context
    }
    
    // From the markdown file
    var mdContent: Component  {
        let path =  context.site.path(for: .home).parent + "Content-custom/homeMain.md"
        
        let file = try? File(path: path)
        let string = (try? file?.readAsString()) ?? ""
        return ComponentGroup {
            Markdown(string)
        }
    }
    

    // Photo Gallery
    let pgComponentGroup = ComponentGroup {
       Text("Summer Travel Photo Galleries")
       ImageGalleryLinkSet(197, 198)
       EmptyComponent()
    }

    // Video Galleries
    
    //  let vgLink1 = VideoGalleryLink(url: "/video/2025-night-watch-1---twofer--getting-out-of-nola--blue-water-and-dolphins/", image: "mq20250611.jpg", caption: "2025 Night Watch #1 (of very few)")
    //  let vgLink2 = VideoGalleryLink(url: "/video/sail-plan-route/", image: "mq20231028b.jpg", caption: "2024 Velvet Elvis Sail Plan")

    
    
    var body: Component {
        Div {
            mdContent
            pgComponentGroup
            EmptyComponent()
        }.class("div-home-main-mess")
    }
}
