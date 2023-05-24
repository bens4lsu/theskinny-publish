//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/24/23.
//

import Foundation
import Plot
import Publish

extension PublishingStep where Site == Theskinny {
    
    static func writePostPages() -> Self {
        
        .step(named: "Write Post Pages") { context in
            guard let allPosts = context.allBlogPosts else { return }
            let factory = TsobHTMLFactory()
            let postsPerPage = EnvironmentKey.blogPostsPerPage
            var numPages = allPosts.count / postsPerPage
            let postsOnLastPage = allPosts.count % postsPerPage
            if postsOnLastPage > 0 {
                numPages += 1
            }
            for i in 0..<numPages {
                var includePosts = [BlogPost]()
                let leftLinkInfo: TopNavLinks.LinkInfo? = (i == 0) ? nil : TopNavLinks.LinkInfo(text: "previous", url: "/blog2/page-\(i-1)")
                let rightLinkInfo: TopNavLinks.LinkInfo? = (i == numPages - 1) ? TopNavLinks.LinkInfo(text: "next", url: "/blog2/page-\(i+1)") : nil
                let linkInfo = TopNavLinks(leftLinkInfo: leftLinkInfo, rightLinkInfo: rightLinkInfo)
                let pageName = i == 0 ? "current" : "page-\(i)"
                let postsThisPage = (postsPerPage >= (i * postsPerPage + postsPerPage)) ? postsOnLastPage : postsPerPage
                for j in 0..<postsThisPage {
                    includePosts.append(allPosts.items[i * postsPerPage + j])
                }
                let posts = BlogPosts(items: includePosts)
                var page = Page(path: "blog2/\(pageName)", content: Content())
                let html = factory.makeMultiPageHTML(for: page, context: context, from: posts, withLinks: linkInfo)
                page.content.body.html = html.render()
                context.addPage(page)
            }
            
        }
    }
}
