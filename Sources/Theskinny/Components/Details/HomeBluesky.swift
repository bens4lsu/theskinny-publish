//
//  HomeBluesky.swift
//  Theskinny
//
//  Created by Ben Schultz on 2024-10-03.
//

import Foundation
import Publish
import Plot

struct HomeBluesky: Component {
    var body: Component {
        Div {
            Div {
                H1("Links/Quick Thoughts")

                Markdown("""
                    <bsky-embed
                    username="bens4lsu.bsky.social"
                    mode=""
                    limit="9"
                    link-target="_blank"
                    link-image="true"
                    load-more="true"
                    custom-styles="\(customStyles)"
                  >
                  </bsky-embed>
                """)
                
                Div {
                    Link("More posts, powered by Bluesky for now...", url: "https://bsky.app/profile/bens4lsu.bsky.social").toNewScreen()
                }.class("mt-footer")
            }.class("mt-timeline")
        }.class("div-home-tweets")
    }
    
    var customStyles: String { """

    .w-full { padding-right: 15px; }
    
    article article { 
        max-width: 285px;
        position: relative;
        left: -15px;
    }
    
    article article.border-slate-300 {
        border: 1px solid #a6a6a6;
        border-radius: 8px;
    }
    
    article:first-of-type {
        border-top: 2px solid #a6a6a6;
    }
    
    .gap-2, .w-full:before, .border-slate-300 {
        border-style: none;
    }
    
    .mt-8 { display: none; }

    """
    }
}


