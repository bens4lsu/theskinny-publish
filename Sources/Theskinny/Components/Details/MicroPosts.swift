//
//  File.swift
//  
//
//  Created by Ben Schultz on 2024-09-04.
//

import Foundation
import Plot
import Publish



struct MicroPosts: Component {
    let mposts: [MicroPost]
    let allYears: Set<String>
    let year: String
    
    func bodySorted(url: String, direction: (MicroPost, MicroPost) -> Bool) -> Component {
        
        let sortedPosts = mposts.sorted(by: direction)
        
        return Article {
            Paragraph("When Twitter became a cesspool in 2023, I wrote a little script to pull down my old data.  I repurposed it here, again with a program, so if you read something from a random old year, you might just be the first person ever to read it.  In other words, there's no editing going on here.  You can see that in 2023, I jumped from Twitter to Mastodon to post thoughts on my home page, so there's a little icon to tell you where the source was.").class("pg-instruction-box caption")
            H4("Previous Years")
            previousYearLinks()
            Div {
                
                H2("\(year) Micro Posts from Social Media").class("h2-micro-post-header")
                H2 { Link("↕ Reverse Post Order", url: url) }.class("h2-micro-post-header")
                List(sortedPosts) { post in
                    post
                }.listStyle(.listAsDivs)
            }.class("micro-post-parent-container")
        }
    }

    var body: Component {
        EmptyComponent()
    }
      
    
    func previousYearLinks() -> Component {
        var yearsToLink = allYears
        yearsToLink.remove(year)
        
        return List(yearsToLink.sorted()) { year in
            Link(year, url: "/micro-posts/\(year)")
        }.listStyle(.inlineListOfLinks)
    }
}


// MARK: static

extension MicroPosts {
    static var allYearLinks: Component {
        return Article {
            H2("See Tweets/Micro-posts for any year listed")
            List(MicroPostData.years.sorted()) { year in
                Link(year, url: "/micro-posts/\(year)")
            }.listStyle(.inlineListOfLinks)
        }
    }
}

