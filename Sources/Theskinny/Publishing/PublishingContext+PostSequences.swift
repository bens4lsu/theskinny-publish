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
    
    var videoAlbums: [VideoAlbum] {
        let path =  self.site.path(for: Theskinny.SectionID.home).parent + "Content-custom/video-metadata/"
        let decoder = YAMLDecoder()
        var albums = [VideoAlbum]()
        do {
            try Folder(path: path).files.enumerated().forEach { (index, file) in
                //print (file)
                let fileYaml = try file.readAsString()
                var decoded = try decoder.decode(VideoAlbum.self, from: fileYaml)
                //print ("video gallery \(decoded.id): \(decoded.videos.count) videos")
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
    
    var bigtripVideos: [Video] {
        let albumIdsToInclude = [9123001, 9123003]
        let albumsForThisSet = videoAlbums.filter { albumIdsToInclude.contains($0.id) }
        return albumsForThisSet.flatMap { $0.videos }
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
    
    var bigTripPGs: [Gallery] {
        let pgSet = [
            try? Gallery(181, dateString: "2024-01-29"),
            try? Gallery(182, dateString: "2024-02-21"),
            try? Gallery(183, dateString: "2024-03-09"),
            try? Gallery(184, dateString: "2024-04-17"),
            try? Gallery(185, dateString: "2024-04-18"),
        ].compactMap{ $0 }
        return pgSet
    }
    
    var bigtripAll: TripPosts {
        let typeErasedBlogPosts = self.bigtripPosts.items.map {
            TripPost(.blogPost($0))
        }
        let typeErasedVideos = self.bigtripVideos.map {
            TripPost(.video($0))
        }
        let typeErasedGalleries = self.bigTripPGs.map {
            TripPost(.pg($0))
        }
        return TripPosts(items: typeErasedBlogPosts + typeErasedVideos + typeErasedGalleries)
    }
    
    var microPosts: [MicroPost] {
        let paths =  [self.site.path(for: Theskinny.SectionID.home).parent + "Content-custom/mastodon-posts.yaml",
                      self.site.path(for: Theskinny.SectionID.home).parent + "Content-custom/twitter-posts.yaml"
        ]
        
        let decoder = YAMLDecoder()
        var decoded = [MicroPost]()
        do {
            for path in paths {
                let file = try File(path: path)
                let fileYaml = try file.readAsString()
                decoded += try decoder.decode([MicroPost].self, from: fileYaml)
            }
        } catch(let e) {
            print ("Yaml file decode error on:  \(e)")
        }
        return decoded
    }

}


