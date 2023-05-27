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
        .step(named: "Write Post Summary Pages") { context in
            guard let allPosts = context.allBlogPostsReversed?.items else { return }
            let factory = TsobHTMLFactory()
            let postsPerPage = EnvironmentKey.blogPostsPerPage
            var numPages = allPosts.count / postsPerPage
            let postsOnLastPage = allPosts.count % postsPerPage
            if postsOnLastPage > 0 {
                numPages += 1
            }
            for i in 0..<numPages {
                var includePosts = [BlogPost]()
                
                let pageName = i == 0 ? "current" : "page-\(i)"
                
                let rightLinkInfo: TopNavLinks.LinkInfo? = {
                    switch i {
                    case 0:
                        return nil
                    case 1:
                        return TopNavLinks.LinkInfo(text: "newer", url: "/blog/current")
                    default:
                        return TopNavLinks.LinkInfo(text: "newer", url: "/blog/page-\(i - 1)")
                    }
                }()
                let leftLinkInfo: TopNavLinks.LinkInfo? = (i == numPages - 1) ? nil : TopNavLinks.LinkInfo(text: "older", url: "/blog/page-\(i + 1)")
                let linkInfo = TopNavLinks(leftLinkInfo: leftLinkInfo, rightLinkInfo: rightLinkInfo)
                
                let postsThisPage = (postsPerPage >= (i * postsPerPage + postsPerPage)) ? postsPerPage : postsOnLastPage
                for j in 0..<postsThisPage {
                    //print ("\(allPosts.count)  \(i)  \(j)  \(postsThisPage)  \(i * postsPerPage + j)")
                    includePosts.append(allPosts[i * postsPerPage + j])
                }
                let posts = BlogPosts(items: includePosts)
                let page = Page(path: "blog/\(pageName)/index.html", content: Content())
                let html = factory.makeMultiPageHTML(for: page, context: context, from: posts, withLinks: linkInfo)
                let file = try context.createOutputFile(at: page.path)
                try file.write(html.render(indentedBy: .spaces(4)))
            }
        }
    }
}
