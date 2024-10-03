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
                    custom-styles=".border-slate-300 { border-color: red; }"
                  >
                  </bsky-embed>
                """)
                
            }.class("mt-timeline")
        }.class("div-home-tweets")
    }
}
