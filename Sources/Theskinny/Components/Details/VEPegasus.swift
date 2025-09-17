//
//  File.swift
//  Theskinny
//
//  Created by Ben Schultz on 2025-09-17.
//

import Foundation
import Publish
import Plot

struct VEPegasusHome: Component {
    
    let mdComponent: Page
    
    init(mdComponent: Page) {
        self.mdComponent = mdComponent
        
    }
    
    var body: Component {
        Article {
            ComponentGroup {
                Markdown(mdComponent.body.html)
                H2("2024 Back Home")
                VideoData.aVideo(forId: 912345035)
                H2("2025 Bahamas Trip")
                VideoData.aVideo(forId: 912345041)
                BlogPost(slug: "sunshine-sand-and-sepsis").postShortBox
                (try? Gallery(197, dateString: "2024-09-03").postShortBox) ?? EmptyComponent()
            }
        }
    }
}
