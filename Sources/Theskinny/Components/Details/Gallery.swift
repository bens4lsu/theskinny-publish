//
//  File.swift
//  
//
//  Created by Ben Schultz on 2024-01-29.
//

import Foundation
import Plot
import Publish
import Ink
import Files

struct Gallery: Component {
    var id: Int
    var name: String
    var path: String
    var filePath: String
    var imgRootPath: String
    var html: String?
    var normalImagePath: String
    var redImagePath: String
    var images = [GalleryImage]()
    var date: Date?
    
    init (id: Int, name: String, path: String, filePath: String, imgRootPath: String, html: String?, normalImagePath: String, redImagePath: String, images: [GalleryImage]) {
        self.id = id
        self.name = name
        self.path = path
        self.filePath = filePath
        self.imgRootPath = imgRootPath
        self.html = html
        self.normalImagePath = normalImagePath
        self.redImagePath = redImagePath
        self.images = images
    }

    init(_ id: Int) throws {
        let galleryLoad = Galleries.imageGalleries.filter{ $0.id == id }.first
        guard let gallery = galleryLoad else {
            throw GalleryLoadError.attemptToLoadGalleryWithInvalidID
        }
        self = gallery
    }
    
    init(_ id: Int, dateString: String ) throws {
        try self.init(id)
        self.date = EnvironmentKey.yyyyMMddDateFormatter.date(from: dateString)
    }
    
    var dateString: String {
        guard let date else {
            return ""
        }
        return EnvironmentKey.defaultDateFormatter.string(from: date)
    }
    
    var redImageScript: Script {
        Script("""
            img\(id)Normal = new Image;
            img\(id)Red = new Image;
            img\(id)Normal.src = "\(normalImagePath)";
            img\(id)Red.src = "\(redImagePath)";
        """)
    }
    
    var body: Component {
        Div {
            TopNavLinks(LinkInfo("Back to List of Galleries", "/pgHome")
                        , nil
                        , nil)
            Div ("Picture Navigation: Click any thumbnail to open the full size image and caption.  When the full image appears, you can scroll to the next using left and right buttons to the corresponding side of the picture.  Your keyboard's arrow keys should also work, as will the scroll wheel on most computers.").class("pg-instruction-box caption")
            Markdown(html ?? "")
            Div {
                List(images) { image in
                    image.body(galRoot: imgRootPath)
                }.listStyle(.listAsDivs)
            }.class("pg-thb-grid")
        }
    }
    
    var cell: Component {
        Div {
            Link(url: path){
                Image(normalImagePath).attribute(named: "name", value: "i\(id)").class("pgHome-image-link")
            }.attribute(named: "onmouseover", value: "chgImg ('i\(id)','img\(id)Red')")
                .attribute(named: "onmouseout", value: "chgImg ('i\(id)','img\(id)Normal')")
            Paragraph(name).class("caption")
        }
    }
    
    var postShortBox: Component {
        Div {
            H2{
                Link(name, url: path)
            }
            H3(dateString)
        }.class("divPostShort")
    }
    
    
}
