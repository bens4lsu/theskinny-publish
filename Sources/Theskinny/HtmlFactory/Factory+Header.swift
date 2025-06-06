//
//  File.swift
//  
//
//  Created by Ben Schultz on 6/13/23.
//

import Foundation
import Plot
import Publish
import Ink

extension TsobHTMLFactory {
    
    struct HeaderInfo {
        let site: any Website = Theskinny()
        let location: Location
        let title: String
        let rssFeedPath: Path? = .defaultForRSSFeed
        let rssFeedTitle: String? = nil
        let stylesheetPaths: [Path] = ["/style/lightview.css",
                                       //"/style/mastodon-timeline.css?v=\(EnvironmentKey.styleAndScriptVersion)",
                                       "/style/style.css?v=\(EnvironmentKey.styleAndScriptVersion)",
        ]
        let scriptPaths: [Path] = ["https://code.jquery.com/jquery-3.7.0.min.js",
                                   "https://www.googletagmanager.com/gtag/js?id=G-KL8PZZGY28",
                                   "/scripts/lightview.js",
                                   //"/scripts/mastodon-timeline.js",
                                   "/scripts/bluesky-timeline.js",
                                   "/scripts/menu.js?v=\(EnvironmentKey.styleAndScriptVersion)",
                                   // - now this is written directly into index.html  "./scripts/dailyphotoimgage.js"
        ]
        
        
        let gaScript = """
              window.dataLayer = window.dataLayer || [];
              function gtag(){dataLayer.push(arguments);}
              gtag('js', new Date());

              gtag('config', 'G-KL8PZZGY28');
        """
        
        //var gaNode: Node<HTML.HeadContext> { .script(.text(gaScript)) }
        
        var additionalNodeGa: () -> Node<HTML.HeadContext> {
            {() -> Node<HTML.HeadContext> in
                return .script(.text(gaScript))

            }
        }
        
        var additionalNodes = [Node<HTML.HeadContext>]()
        
        let noCacheAttrib1 = Attribute<HTML.MetaContext>(name: "http-equiv", value: "pragma")
        let noCacheAttrib2 = Attribute<HTML.MetaContext>(name: "content", value:"no-cache")
        
        let noCacheAttrib3 = Attribute<HTML.MetaContext>(name: "http-equiv", value:"cache-control")
        let noCacheAttrib4 = Attribute<HTML.MetaContext>(name: "content", value:"no-cache, no-store, must-revalidate, max-age=0")
        
        let noCacheAttrib5 = Attribute<HTML.MetaContext>(name: "http-equiv", value:"expires")
        let noCacheAttrib6 = Attribute<HTML.MetaContext>(name: "content", value:"0")
        
        //<meta http-equiv="cache-control" content="no-cache, no-store, must-revalidate, max-age=0">
        //<meta http-equiv="pragma" content="no-cache">
        //<meta http-equiv="expires" content="0">
        
        var node: Node<HTML.DocumentContext> {
            .head(
                .encoding(.utf8),
                .siteName(site.name),
                .url(site.url(for: location)),
                .title(title),
                .description(site.description),
                .twitterCardType(location.imagePath == nil ? .summary : .summaryLargeImage),
                .forEach(scriptPaths, { return .script(.src($0.string)) as Node<HTML.HeadContext> }),
                .forEach(stylesheetPaths, { .stylesheet($0) }),
                .viewport(.accordingToDevice),
                .unwrap(site.favicon, { _ in .favicon("/img/headers/favicon.ico") }),
                .unwrap(rssFeedPath, { path in
                    let title = rssFeedTitle ?? "Subscribe to \(site.name)"
                    return .rssFeedLink(path.absoluteString, title: title)
                }),
//                .unwrap(location.imagePath ?? site.imagePath, { path in
//                    let url = site.url(for: path)
//                    return .socialImageLink(url)
//                }),
                .forEach(additionalNodes, { addNode in
                    addNode
                }),
                .meta(noCacheAttrib1, noCacheAttrib2),
                .meta(noCacheAttrib3, noCacheAttrib4),
                .meta(noCacheAttrib5, noCacheAttrib6),
                additionalNodeGa()
            )
        }
    }
}
