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
       H2("New Photo Collection -- Pet Explosion")
       ImageGalleryLinkSet(200)
       EmptyComponent()
    }

    // Video Galleries
    
    let vgComponentGroup = ComponentGroup {
        H2("Someone help me out with this one...")
        VideoGalleryLink(url: "/video/i-have-no-idea-what-to-do-with-this-striping/", image: "mq20260209.jpg", caption: "")
        Text("The city painted some new street stripes on S. Harrlels Ferry Rd, which is kind of a major street.  I honestly have no idea when I'm supposed to go where as I approach Sherwood Forest Blvd.  Watch the vid and let me know.")
        
        
    }
    
    
    var body: Component {
        Div {
//            mdContent
//            pgComponentGroup
            vgComponentGroup
            EmptyComponent()
        }.class("div-home-main-mess")
    }
}
