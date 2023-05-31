//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/15/23.
//
import Foundation
import Publish
import Plot

struct TsobHTMLFactory: HTMLFactory {
    
    enum TsobHTMLFactoryError: Error {
        case contextMissingAllPosts
        case currentPostNotFoundInContext
        case currentPostMissingIDInMetadata
        case adopPostWihtoutSection
        case currentAdopPostsMissingSlug
    }
    
    struct HeaderInfo {
        let site: any Website = Theskinny()
        let location: Location
        let title: String
        let rssFeedPath: Path? = .defaultForRSSFeed
        let rssFeedTitle: String? = nil
        let stylesheetPaths: [Path] = ["/TsobTheme/style.css?\(UUID().uuidString)"]
        let scriptPaths: [Path] = ["https://code.jquery.com/jquery-3.7.0.min.js", "/scripts/menu.js?\(UUID().uuidString)"]
        let additionalNodes = [() -> Node<HTML.HeadContext>]()
        
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
                .unwrap(site.favicon, { .favicon($0) }),
                .unwrap(rssFeedPath, { path in
                    let title = rssFeedTitle ?? "Subscribe to \(site.name)"
                    return .rssFeedLink(path.absoluteString, title: title)
                }),
                .unwrap(location.imagePath ?? site.imagePath, { path in
                    let url = site.url(for: path)
                    return .socialImageLink(url)
                }),
                .forEach(additionalNodes, { addNode in
                    addNode()
                })
            )
        }
    }
        
    
    func makeIndexHTML(for index: Publish.Index, context: Publish.PublishingContext<Theskinny>) throws -> Plot.HTML {
        // make index html = home html
        let sections = context.sections
        let section = sections.first(where: { $0.id.rawValue == "home" })!
            
        return try makeHomeHTML(for: index, section: section, context: context)
    }
    
    
    func makeTagListHTML(for page: Publish.TagListPage, context: Publish.PublishingContext<Theskinny>) throws -> Plot.HTML? {
        HTML(.text("Hello tag list"))
    }
    


    
    
    

}
