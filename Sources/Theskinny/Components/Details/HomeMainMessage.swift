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
        VideoGalleryLink(url: "/video/warriors-in-training/", image: "mq20260105.jpg", caption: "Stick around to the end for puppy wind sprints.")
        
        
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
