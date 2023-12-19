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
            var ogImgStr = ogImg
            if ogImg.prefix(4) != "http" && ogImg.prefix(5) != "/img/" {
                ogImgStr = context.site.url.absoluteString + "/img/" + ogImg
            }
            return .meta(Attribute(name: "property", value: "og:image"), Attribute(name: "content", value: ogImgStr))
        }
        // TODO:  return first image in body if none specified in metadata
        
        return .empty
    }
}
