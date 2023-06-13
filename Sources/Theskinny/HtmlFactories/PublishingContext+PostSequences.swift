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
                return BlogPost(title: item.title, slug: slug, date: item.date, content: item.content.body, id: id, description: item.metadata.description ?? "Description not provided")
            }.sorted(by: { $0.date < $1.date })
            return BlogPosts(items: blogPosts)
        } catch {
            exit(0)
        }
    }
    
    var allBlogPostsReversed: BlogPosts? {
        guard let tmpBlogPosts = allBlogPosts else {
            return nil
        }
        let reversedItems = tmpBlogPosts.items.reversed() as [BlogPost]
        return BlogPosts(items: reversedItems)
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
    
    var videoAlbums: [VideoAlbum] {
        let path =  self.site.path(for: .home).parent + "Content-custom/video-metadata/"
        let decoder = YAMLDecoder()
        var albums = [VideoAlbum]()
        do {
            try Folder(path: path).files.enumerated().forEach { (index, file) in
                //print (file)
                let fileYaml = try file.readAsString()
                var decoded = try decoder.decode(VideoAlbum.self, from: fileYaml)
                let preFilterCount = decoded.videos.count
                decoded.videos = decoded.videos.filter {
                    $0.embed.count > 0
                }
                if decoded.videos.count != preFilterCount {
                    print ("WARNING: videos eliminated because no emded code in \(file.name)")
                }
                if decoded.videos.count > 0 {
                    albums.append(decoded)
                }
            }
        } catch(let e) {
            print ("Video album file or decode error on:  \(e)")
        }
        return albums
    }
}
