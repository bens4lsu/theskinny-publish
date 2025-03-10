//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/24/23.
//

import Foundation
import Publish
import Files
import Yams
import Plot

extension PublishingContext where Site == Theskinny {
    
    var allBlogPosts: BlogPosts? {
        guard let blog2Section = self.sections.filter({ $0.id == .blog2 }).first
        else {
            return nil
        }
        do {
            let blogPosts = try blog2Section.items.map { item in
                guard let id = item.metadata.id else {
                    throw TsobHTMLFactory.TsobHTMLFactoryError.currentPostMissingIDInMetadata
                }
                let slug = URL(string: item.path.string)?.lastPathComponent ?? item.path.string
                return BlogPost(title: item.title, slug: slug, date: item.date, content: item.content.body, id: id, description: item.metadata.description ?? "Description not provided", tags: item.tags, ogImg: item.metadata.ogImg)
            }.sorted(by: { $0.date < $1.date })
            return BlogPosts(items: blogPosts)
        } catch {
            exit(0)
        }
    }
    
    var allBlogPostsReversed: BlogPosts {
        guard let tmpBlogPosts = allBlogPosts else {
            return BlogPosts(items: [])
        }
        let reversedItems = tmpBlogPosts.items.reversed() as [BlogPost]
        return BlogPosts(items: reversedItems)
    }
    
    var beneteauBlogPosts: BlogPosts {
        guard let tmpBlogPosts = allBlogPosts else {
            return BlogPosts(items: [])
        }
        
        let beneteauPosts = tmpBlogPosts.items.filter { item in
            item.tags.contains { tag in
                tag.string == "velvet-elvis-beneteau"
            }
        }
        return BlogPosts(items: beneteauPosts)
    }
    
    var adopPosts: AdopGeneral? {
        let sections = self.sections.filter({ $0.id == .adopk || $0.id == .adopv })
        var adopItems = [AdopItem]()
        for section in sections {
            do {
                adopItems += try section.items.map { item in
                    guard let adopSection = item.metadata.adopSection else {
                        throw TsobHTMLFactory.TsobHTMLFactoryError.adopPostWihtoutSection
                    }
                    return AdopItem(title: item.title, date: item.date, section: adopSection, content: item.content.body, slug: item.path.string, siteSection: section)
                }
            } catch (let err){
                print ("Error: \(err)")
                exit(0)
            }
        }
        return AdopGeneral(items: adopItems)
    }
    

    
    var bigtripPosts: BlogPosts {
        guard let section = self.sections.filter({ $0.id == .bigtrip }).first
        else {
            return BlogPosts(items: [])
        }
        let posts = section.items.map { item in
            let slug = URL(string: item.path.string)?.lastPathComponent ?? item.path.string
            let blogPost = BlogPost(title: item.title, slug: slug, date: item.date, content: item.content.body, id: item.metadata.id ?? -93, description: item.metadata.description ?? "Description not provided", tags: item.tags, ogImg: item.metadata.ogImg)
            return blogPost
        }.sorted(by: { $0.date < $1.date })
        return BlogPosts(items: posts)
    }
    
    
    
    var bigtripAll: TripPosts {
        let typeErasedBlogPosts = self.bigtripPosts.items.map {
            TripPost(.blogPost($0))
        }
        let typeErasedVideos = VideoData.bigtripVideos.map {
            TripPost(.video($0))
        }
        let typeErasedGalleries = EnvironmentKey.bigTripPGs.map {
            TripPost(.pg($0))
        }
        return TripPosts(items: typeErasedBlogPosts + typeErasedVideos + typeErasedGalleries)
    }

}


