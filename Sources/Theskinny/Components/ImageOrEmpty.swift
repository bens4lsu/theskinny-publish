//
//  File.swift
//  
//
//  Created by Ben Schultz on 2023-12-07.
//

import Foundation
import Publish
import Plot

//
//public struct ImageOrEmpty: Component {
//    /// The URL of the image to render.
//    public var url: URLRepresentable
//    /// An alternative text that describes the image in case it couldn't be
//    /// loaded, or if the user is using a screen reader.
//    public var description: String
//    
//    
//
//    /// Create a new image instance.
//    /// - parameters:
//    ///   - url: The URL of the image to render.
//    ///   - description: An alternative text that describes the image in case
//    ///     it couldn't be loaded, or if the user is using a screen reader.
//    public init(url: URLRepresentable?,
//                description: String) {
//        self.url = url ?? emptyImg
//        self.description = description
//    }
//
//    /// Create a new decorative image that doesn't have a description.
//    /// - parameter url: The URL of the image to render.
//    public init(_ url: URLRepresentable?) {
//        self.init(url: url, description: "")
//    }
//
//    public var body: Component {
//        Node<HTML.BodyContext>.img(.src(url), .alt(description))
//    }
//}
