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
       H2("Summer Travel Photo Galleries")
       ImageGalleryLinkSet(197, 198)
       EmptyComponent()
    }

    // Video Galleries
    
    let vgComponentGroup = ComponentGroup {
        H2("Some new videos...")
        VideoGalleryLink(url: "/video/the-seagulls-are-out-of-control-in-new-orleans/", image: "mq20251020a.jpg", caption: "The seagulls are out of control in New Orleans right now.")
    }
    
    
    var body: Component {
        Div {
            mdContent
            //pgComponentGroup
            vgComponentGroup
            EmptyComponent()
        }.class("div-home-main-mess")
    }
}
