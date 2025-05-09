//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/16/23.
//

import Foundation
import Publish
import Plot


extension TsobHTMLFactory {
    
    func makeItemHTML(for item: Publish.Item<Theskinny>, context: Publish.PublishingContext<Theskinny>) throws -> Plot.HTML {
        switch item.sectionID.rawValue {
        case "blog2":
            return try makePostHTML(for: item, context: context)
        case "haikus":
            return try makeHaikuHTML(for: item, context: context)
        case "njdispatches":
            return try makeNJHTML(for: item, context: context)
        case "adopv", "adopk":
            return try makeAdopHTML(for: item, context: context)
        case "vid":
            return makeVidHTML(for: item, context: context)
        case "big-trip":
            return try makeTripHTML(for: item, context: context)
        default:
            return HTML(.text("item HTML not yet implemented"))
        }
    }
    
    
    fileprivate func makePostHTML(for item: Item<Theskinny>, context: PublishingContext<Theskinny>) throws -> Plot.HTML {
     
        // have to work with all posts in order to get the links at the top
        guard let allPosts = context.allBlogPosts else {
            throw TsobHTMLFactoryError.contextMissingAllPosts
        }
        guard let id = item.metadata.id else {
            throw TsobHTMLFactoryError.currentPostMissingIDInMetadata
        }
        guard let post = allPosts.post(withId: id) else {
            throw TsobHTMLFactoryError.currentPostNotFoundInContext
        }
        var htmlHeadInfo = HeaderInfo(location: item, title: item.title + " -- on theskinnyonbenny.com")
        htmlHeadInfo.additionalNodes.append(Node.ogImgNode(item.metadata.ogImg, context: context))
        htmlHeadInfo.additionalNodes.append(Node.ogTypeNodeArticle())
        let pageMain = AnyPageMain(mainContent: post, site: context.site)
        return HTML(
            htmlHeadInfo.node,
            .body(.component(pageMain)
           )
        )
    }
 
    fileprivate func makeVidHTML(for item: Item<Theskinny>, context: PublishingContext<Theskinny>) -> HTML {
        // this is a page that lists several albums.  clicking on the albums should go to a page that lists all
        // of the videos for that album.
        let htmlHeadInfo = HeaderInfo(location: context.index, title: "Video Albums on theskinnyonbenny.com")
        var albumsToShow = VideoData.videoAlbums.filter { album in
            item.metadata.videoAlbums?.contains(album.id) ?? false
        }.sorted()
        albumsToShow = Array(albumsToShow.reversed())
        let videoAlbumIndex = VideoAlbumIndex(videoAlbums: albumsToShow, title: item.title)
        let pageMain = AnyPageMain(mainContent: videoAlbumIndex, site: context.site)
        return HTML (htmlHeadInfo.node, .body(.component(pageMain)))
    }
    
    fileprivate func makeAdopHTML(for item: Item<Theskinny>, context: PublishingContext<Theskinny>) throws -> Plot.HTML {
     
        // have to work with all posts in order to get the links at the top
        guard let allPosts = context.adopPosts else {
            throw TsobHTMLFactoryError.contextMissingAllPosts
        }
//        guard let id = item.path else {
//            throw TsobHTMLFactoryError.currentAdopPostsMissingSlug
//        }
        guard let post = allPosts.post(withSlug: item.path.string) else {
            throw TsobHTMLFactoryError.currentPostNotFoundInContext
        }
        let htmlHeadInfo = HeaderInfo(location: item, title: "Russian Adoption Story")
        let pageMain = AnyPageMain(mainContent: post, site: context.site)
        return HTML(
            htmlHeadInfo.node,
            .body(.component(pageMain)
           )
        )
    }
    
    
    
    fileprivate func makeHaikuHTML(for item: Item<Theskinny>, context: PublishingContext<Theskinny>) throws ->  Plot.HTML {
        guard let id = item.metadata.id else {
            throw TsobHTMLFactoryError.currentPostMissingIDInMetadata
        }
        let htmlHeadInfo = HeaderInfo(location: item, title: "Tyler's Haikus on theskinnyonbenny.com")
        let haiku = Haiku(title: item.content.title, date: item.content.date, content: item.content.body, id: id)
        let pageMain = AnyPageMain(mainContent: haiku, site: context.site, custPersonImageClass: "topleft-tc", custHeaderClass: "header-tc")

        return HTML(
            htmlHeadInfo.node,
            .body(.component(pageMain))
        )
    }
    
    fileprivate func makeNJHTML(for item: Item<Theskinny>, context: PublishingContext<Theskinny>) throws -> Plot.HTML {
        guard let id = item.metadata.id else {
            throw TsobHTMLFactoryError.currentPostMissingIDInMetadata
        }
        let htmlHeadInfo = HeaderInfo(location: item, title: "Shelly's NJ Dispatches on theskinnyonbenny.com")
        let dispatch = NJDispatch(title: item.content.title, date: item.content.date, content: item.content.body, id: id)
        let pageMain = AnyPageMain(mainContent: dispatch, site: context.site, custPersonImageClass: "topleft-sw", custHeaderClass: "header-sw")

        return HTML(
            htmlHeadInfo.node,
            .body(.component(pageMain))
        )
    }
    
    fileprivate func makeTripHTML(for item: Publish.Item<Theskinny>, context: Publish.PublishingContext<Theskinny>) throws -> Plot.HTML {
        guard 
            let id = item.metadata.id,
            let tripPost = context.bigtripPosts.postInBigTrip(withId: id)
        else {
            throw TsobHTMLFactoryError.currentPostMissingIDInMetadata
        }
        let pageTitle = item.title + " -- on theskinnyonbenny.com"
        var htmlHeadInfo = HeaderInfo(location: context.index, title: pageTitle)
        htmlHeadInfo.additionalNodes.append(Node.ogImgNode(item.metadata.ogImg, context: context))
        htmlHeadInfo.additionalNodes.append(Node.ogTypeNodeArticle())
        let pageContent = TripPost(.blogPost(tripPost))
        let pageMain = AnyPageMain(mainContent: pageContent, site: context.site)
        return HTML(
            htmlHeadInfo.node,
            .body(.component(pageMain))
        )
    }
    
}
