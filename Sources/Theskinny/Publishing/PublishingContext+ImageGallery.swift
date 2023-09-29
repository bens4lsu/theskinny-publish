//
//  File.swift
//  
//
//  Created by Ben Schultz on 2023-09-28.
//

import Foundation
import Plot
import Publish
import Files


enum GalleryLoadError: Error {
    case noSpaceInDirectoryName
    case nonIntegerFirstPartOfDirectoryName
    case errorReadingCaptionFile
}

extension PublishingContext where Site == Theskinny {
    
    var imageGalleries: Galleries {
        let galFromSiteRoot = "Resources/gal/"
        let galFromHttpRoot = "/gal/"
        let imgFromHttpRoot = "/img/gal/"
        do {
            var galleries = [Gallery]()
            let topFolder = try folder(at: Path(galFromSiteRoot))
            try topFolder.subfolders.forEach { galFolder in
                let (id, name) = try Self.idFromFolderName(atPath: galFolder.name)
                let galleryPath = galFromHttpRoot + String(id)
                let filePath = galFromSiteRoot + galFolder.name
                let imgRootPath = imgFromHttpRoot + galFolder.name + "/"
                let normalImagePath = imgRootPath + "/data/normal.jpg"
                let redImagePath = imgRootPath + "/data/red.jpg"
                let images = try Self.galleryImages(inPath: filePath)
                let htmlFilePath = Path(filePath + "/gal-desc.txt")
                let html = try file(at: htmlFilePath).readAsString()
                galleries.append( Gallery(id: id, name: name, path: galleryPath, filePath: filePath, imgRootPath: imgRootPath, html: html, normalImagePath: normalImagePath, redImagePath: redImagePath, images: images))
            }
            return Galleries(list: galleries)
        } catch (let e) {
            print ("Error loading image galleries: \(e)")
        }
        return Galleries(list: [])
    }
    
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
