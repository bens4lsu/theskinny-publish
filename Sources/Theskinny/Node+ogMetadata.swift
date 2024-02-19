//
//  File.swift
//  
//
//  Created by Ben Schultz on 2023-12-18.
//

import Foundation
import Publish
import Plot


extension Node where Context == HTML.BodyContext {

    static func ogImgNode(_ ogImg: String?, context: PublishingContext<Theskinny>) -> Node<HTML.HeadContext> {
        if let ogImg {
            var ogImgStr = Theskinny.imagePathFromMetadata(for: ogImg)
            return .meta(Attribute(name: "property", value: "og:image"), Attribute(name: "content", value: ogImgStr))
        }
        // TODO:  return first image in body if none specified in metadata
        
        return .empty
    }
    
    static func ogTypeNodeArticle() -> Node<HTML.HeadContext> {
        .meta(Attribute(name: "property", value: "og:type"), Attribute(name: "content", value: "article"))
    }

}
