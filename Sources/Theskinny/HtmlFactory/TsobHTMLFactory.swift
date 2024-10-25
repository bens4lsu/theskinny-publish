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
    
    typealias Site = Theskinny
    
    enum TsobHTMLFactoryError: String, Error {
        case contextMissingAllPosts
        case currentPostNotFoundInContext
        case currentPostMissingIDInMetadata
        case adopPostWihtoutSection
        case currentAdopPostsMissingSlug
    }
    

        
    func makeHomeHTML<T: Website>(for index: Index, section: Section<T>, context: PublishingContext<Theskinny>) throws -> HTML {
        var htmlHeadInfo = HeaderInfo(location: context.index, title: "theskinnyonbenny.com")
        htmlHeadInfo.additionalNodes = [Script(DailyPhotoData.scriptImage).headerNode]
        let pageContent = HomePage(context)
        let pageMain = AnyPageMain(mainContent: pageContent, site: context.site)
        
        return HTML(
            htmlHeadInfo.node,
            .body(.component(pageMain))
        )
        
    }
    
    
    func makeIndexHTML(for index: Publish.Index, context: Publish.PublishingContext<Theskinny>) throws -> Plot.HTML {
        // make index html = home html
        let sections = context.sections
        let section = sections.first(where: { $0.id.rawValue == "home" })!
        return try makeHomeHTML(for: index, section: section, context: context)
    }
    
    
    func makeTagListHTML(for page: Publish.TagListPage, context: Publish.PublishingContext<Theskinny>) throws -> Plot.HTML? {
        let htmlHeadInfo = HeaderInfo(location: context.index, title: "Site Tag Index")
        let pageMain = AnyPageMain(mainContent: TagLinks(tags: page.tags), site: context.site)
        return HTML(
            htmlHeadInfo.node,
            .body(.component(pageMain))
        )
    }
    
    
    func makePostsHTML(for section: Section<Theskinny>, context: PublishingContext<Theskinny>) throws -> HTML {
        let htmlHeadInfo = HeaderInfo(location: context.index, title: "")
        return HTML(
            htmlHeadInfo.node,
            .body(.redirect(to: "/blog2/current"))
        )
    }
    

    
    
    func makeRedirectFromOldBlogPath(for page: Publish.Page, context: PublishingContext<Theskinny>, newName: String) -> HTML {
        let script = Script("window.location.replace(\"/blog2/\(newName)\");")
        return HTML(script.convertToNode())
    }
    
    
    func makeTagDetailsHTML(for page: Publish.TagDetailsPage, context: Publish.PublishingContext<Theskinny>) throws -> HTML? {
        let items = context.items(taggedWith: page.tag)
        let postItems = try items.map { item in
            let slug = URL(string: item.path.string)?.lastPathComponent ?? item.path.string
            guard let id = item.metadata.id,
                  let description = item.metadata.description
            else {
                throw TsobHTMLFactoryError.currentPostMissingIDInMetadata
            }
            return BlogPost(title: item.title, slug: slug, date: item.date, content: item.content.body, id: id, description: description, tags: item.tags, ogImg: item.metadata.ogImg)
        }
        let blogPosts = BlogPosts(items: postItems)
        let htmlHeadInfo = HeaderInfo(location: context.index, title: "Blog Index of Articles by Date")
        let topNav = TopNavLinks(LinkInfo("tags", "/tags"), nil, nil)
        let tagDetails = TagDetails(tagName: page.tag.string, blogPosts: blogPosts, topNav: topNav)
        let pageMain = AnyPageMain(mainContent: tagDetails, site: context.site)
        return HTML (
            htmlHeadInfo.node,
            .body(.component(pageMain))
        )
    }

}
