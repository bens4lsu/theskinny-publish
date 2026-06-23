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
                
                // Link to Online, interactive map
                Div {
                    Div {
                        Div {
                            H2{
                                Link("Online, Interactive Map Review", url: "./log")
                            }
    
                            Div("An interactive look at all of the places we've logged.  Most log points have both boat and wind information.")
                        }.class("divPostStuff")
                        Image("/img/video-thumbnails/ve-log-tn.jpg")
                    }.class("divPostFlexbox")
                    TopNavLinks(rightLinkInfo: LinkInfo(text: "interact with the map yourself", url: "./log")).class("divPostEndLink")
                }.class("divPostShort")
                
               
                H2("2024 - The Big Trip")
                Div{
                    Paragraph{
                        Text("Theskinnyonbenny family flew to Slovenia in January of 2024 to take delivery of _Velvet Elvis_ and spent most of the year sailing her home.  ")
                        Link("There are dozens of posts, videos, and photo galleries documenting that trip.", url: "/big-trip")
                    }
                    Paragraph("This is really the page you're looking for, even though the links below are better-highlighted.")
                }
                
                
                H2("2024 Back Home")
                VideoData.aVideo(forId: 912345035)
                H2("2025 Bahamas Trip")
                VideoData.aVideo(forId: 912345041)
                BlogPost(slug: "sunshine-sand-and-sepsis").postShortBox
                (try? Gallery(197, dateString: "2024-09-03").postShortBox) ?? EmptyComponent()
                H2("2026")
                BlogPost(fullPath: "/velvet-elvis/pegasus/2026-spring-work.md").postShortBox
                BlogPost(slug:"the-ditch").postShortBox
                BlogPost(slug:"most-stressful-not-at-all-stressful-passage").postShortBox
            }
        }
    }
}
