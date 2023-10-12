//
//  File.swift
//  
//
//  Created by Ben Schultz on 4/6/23.
//

import Foundation
import Plot
import Publish
import Ink
import Files


enum GalleryLoadError: Error {
    case noSpaceInDirectoryName
    case nonIntegerFirstPartOfDirectoryName
    case errorReadingCaptionFile
    case attemptToLoadGalleryWithInvalidID
}

struct Galleries: Component {
    
    var list: [Gallery]
    
    
    init(list: [Gallery]) {
        // used for ImageGalleryLink -- gallery links in other pages
        self.list = list
    }
    
    init() {
        self.list = Self.imageGalleries
    }
    
    var scripts: ComponentGroup {
        let script1 = Script("""
            function chgImg (imgName, newImg){
                var i = document.getElementsByName(imgName)[0];
                i.src = eval (newImg + ".src");
            }
        """)
        var scripts: [Script] = [script1]
        scripts += list.map { $0.redImageScript }
        return ComponentGroup(members: scripts)
    }
    
    var body: Component {
        let cells = list.map { $0.cell }
        return ComponentGroup {
            scripts
            Div {
                H2("The Photo Collections...")
                Paragraph("Click on any of the pictures in this part of the page to open the whole set of photos for that collection.  If this is your first trip in, give it a minute.  It may take this page a little while to load all of the pictures, but I like having one big giant list of my photo albums in one place.")
                Div {
                    ComponentGroup(members: cells)
                }.class("pg-grid")
            }
        }
    }
}

// MARK:  Static Methods
extension Galleries {
    
    static let imageGalleries: [Gallery] = {
        let galFromSiteRoot = "Resources/img/gal/"
        let galFromHttpRoot = "/gal/"
        let imgFromHttpRoot = "/img/gal/"
        do {
            var galleries = [Gallery]()
            let topFolder = try Folder(path: galFromSiteRoot)
            try topFolder.subfolders.forEach { galFolder in
                let (id, name) = try Self.idFromFolderName(atPath: galFolder.name)
                let galleryPath = galFromHttpRoot + galFolder.name
                let filePath = galFromSiteRoot + galFolder.name
                let imgRootPath = imgFromHttpRoot + galFolder.name + "/"
                let normalImagePath = imgRootPath + "/data/normal.jpg"
                let redImagePath = imgRootPath + "/data/red.jpg"
                let images = try Self.galleryImages(inPath: filePath)
                let htmlFilePath = filePath + "/gal-desc.txt"
                let html = try  File(path: htmlFilePath).readAsString()
                galleries.append( Gallery(id: id, name: name, path: galleryPath, filePath: filePath, imgRootPath: imgRootPath, html: html, normalImagePath: normalImagePath, redImagePath: redImagePath, images: images))
            }
            return galleries.sorted(by: { $0.id > $1.id })
        } catch (let e) {
            print ("Error loading image galleries: \(e)")
        }
        return []
    }()
    
    private static func idFromFolderName(atPath path: String) throws -> (Int, String) {
        guard let idEndIndex = path.firstIndex(of: " ")
        else {
            throw GalleryLoadError.noSpaceInDirectoryName
        }
        let idStartIndex = path.lastIndex(of: "/") ?? path.startIndex
        let idStr = String(path[idStartIndex...idEndIndex]).trimmingCharacters(in: .whitespaces)
        guard let id = Int(idStr) else {
            throw GalleryLoadError.nonIntegerFirstPartOfDirectoryName
        }
        let nameStartIndex = path.index(idEndIndex, offsetBy: 3)
        let name = String(path[nameStartIndex...])
        return (id, name)
    }
    
    private static func galleryImages(inPath path: String) throws -> [GalleryImage] {
        let captionFile = try File(path: path + "/pic-desc.txt")
        guard let captionContents = try? captionFile.readAsString() else {
            throw GalleryLoadError.errorReadingCaptionFile
        }
        let lines = captionContents.split(whereSeparator: \.isNewline)
        var images = [GalleryImage]()
        for i in 0..<lines.count{
            let line = lines[i]
            let split = line.split(separator: "|")
            var caption = ""
            if split.count > 1 {
                caption = String(split[1])
            }
            if split.count >= 1 {      // bug fix 2023-06-02.  don't crash if there's a blank line in pic-desc.
                let imagePath = String(split[0])
                let thumbnailPath = "_thb_" + String(split[0])
                let galleryImage = GalleryImage(lineNum: i+1, imagePath: imagePath, thumbnailpath: thumbnailPath, caption: caption)
                images.append(galleryImage)
            }
        }
        return images
    }

    
}


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
    
    fileprivate init (id: Int, name: String, path: String, filePath: String, imgRootPath: String, html: String?, normalImagePath: String, redImagePath: String, images: [GalleryImage]) {
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
    
    
}


struct GalleryImage: Component {
    var lineNum: Int
    var imagePath: String
    var thumbnailpath: String
    var caption: String
    
    var body: Component { EmptyComponent() }
    
    var escapedCaption: String {
        Markdown(caption).render().replacingOccurrences(of: "\"", with: "&quot;")
    }
    
    func body(galRoot: String) -> Component {
        Link(url: galRoot + imagePath){
            Image(url: galRoot + thumbnailpath, description: imagePath)
        }.class("lightview")
            .attribute(named: "data-lightview-caption", value: escapedCaption)
            .attribute(named: "data-lightview-group", value: "group1")
    }
}


