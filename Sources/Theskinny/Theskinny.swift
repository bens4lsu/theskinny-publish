//
//  File.swift
//  
//
//  Created by Ben Schultz on 2023-11-05.
//

import Foundation
import Publish
import Plot
import Files

struct Theskinny: Website {
    enum SectionID: String, WebsiteSectionID, CaseIterable {
        case home
        case blog2
        case haikus
        case njdispatches
        case adopv
        case adopk
        case vid
        case bigtrip = "big-trip"
    }
    
    struct ItemMetadata: WebsiteItemMetadata {
        var id: Int?
        var description: String?
        var adopSection: String?
        var videoAlbums: [Int]?
        var ogImg: String?
    }
    
    
    var url: URL { URL(string: Self.urlString)! }
    var name = "theskinnyonbenny.com"
    var description = "Personal Website, Ben Schultz, Baton Rouge"
    var language: Language { .english }
    var imagePath: Path? { "img" }
    
    
    
    static var urlString = "https://theskinnyonbenny.com"
    
    static func imagePathFromMetadata(for ogImg: String?) -> String? {
        guard var ogImgStr = ogImg else {
            return nil
        }
        
        if ogImgStr.prefix(4) != "http" && ogImgStr.prefix(5) != "/img/" {
            ogImgStr = "/img/" + ogImgStr
        }
//        else if ogImgStr.first == "/" {
//            ogImgStr = Theskinny.urlString + ogImgStr
//        }
        
        let encoded = ogImgStr.addingPercentEncoding(withAllowedCharacters: .whitespacesAndNewlines.inverted)
        return encoded
    }
    
}
