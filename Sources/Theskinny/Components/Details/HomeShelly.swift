//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/25/23.
//

import Foundation
import Publish
import Plot

struct HomeShelly: Component {
    
    var embedCode = """
        <img src="/img/shelly1.jpg" alt="shelly">
        <div class="caption">"I don't think the new layout of the skinny.  Too busy.  You suck."  -- Shelly Williams, February 15, 2011 via text message</div>
    """
    
    var body: Component {
        Div {
            Div {
                Markdown(embedCode)
            }
        }.class("div-home-shelly")
    }
}
