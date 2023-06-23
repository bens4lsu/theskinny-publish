//
//  File.swift
//  
//
//  Created by Ben Schultz on 6/4/23.
//

import Foundation
import Plot
import Publish

struct ImageGalleryLinkSet: Component {
    
    fileprivate var links: [ImageGalleryLink]
    
//    let listStyle = HTMLListStyle(elementName: "") { listItem in
//        Div(listItem)
//    }
    
    init(_ ids: Int...) {
        self.links = ids.map { id in ImageGalleryLink(id) }
    }
    
    var body: Component {
        Div {
            List(links) { link in
                link
            }.listStyle(.listAsDivs)
        }.class("div-image-gallery-set")
    }
    
    private var jsVarsAndFunctionStr: String { ImageGalleryLink.jsFunctionStr + jsImgVariablesStr }
    
    private var jsImgVariablesStr: String {
        var scriptText = ""
        for link in links {
            scriptText += link.js
        }
        return scriptText
    }
    
    var jsImageVariables: Component { Script(jsImgVariablesStr) }
    var jsAll: Component { Script(jsVarsAndFunctionStr) }
    
//    func maxWidth(_ set: String) -> Component {
//        self.body.style("max-width: \(set)")
//    }
}


fileprivate struct ImageGalleryLink: Component {
    
    struct FromDynamicLookup: Decodable {
        var name: String
        var normalImagePath: String
        var redImagePath: String
    }
    
    var galleryId: Int
    var caption: String
    var redLink: String
    var normalLink: String
    
    var imgVarNameN: String { "img\(galleryId)" }
    var imgVarNameR: String { "img\(galleryId)Red" }
    
    
    var body: Component {
        Div {
            Div {
                Link(url: "https://dynamic.theskinnyonbenny.com/gal/\(self.galleryId)") {
                    Image(self.normalLink).attribute(named: "name", value: imgVarNameN).class("img-gal-link")
                }.attribute(named: "target", value: "_blank")
                    .attribute(named: "onmouseover", value: "chgImg ('\(imgVarNameN)','\(imgVarNameR)');")
                    .attribute(named: "onmouseout", value: "chgImg ('\(imgVarNameN)','\(imgVarNameN)');")
            }
            H3(self.caption)
        }.class("div-image-gallery-link")
    }
    
    var js: String {
         """
            img\(galleryId) = new Image;
            img\(galleryId)Red = new Image;
            img\(galleryId).src = "\(normalLink)";
            img\(galleryId)Red.src = "\(redLink)";
        
        """
    }
    
    static var jsFunctionStr: String {
        """
            function chgImg (imgName, newImg){
                document[imgName].src = eval (newImg + ".src");
            }
        
        """
    }
    
    init (_ id: Int) {
        self.galleryId = id
        let galleryInfo = galArray[id]!
        self.caption = galleryInfo.name
        self.normalLink = galleryInfo.normalImagePath
        self.redLink = galleryInfo.redImagePath
    }
    
    // get the data easilty from https://dynamic.theskinnyonbenny.com/gal/data/###
    let galArray: [Int: FromDynamicLookup] = [
        31: FromDynamicLookup(name: "Russia Trip 1 - Yaroslavl and Ivan",
                              normalImagePath: "https://dynamic.theskinnyonbenny.com/gal/031 - Russia Trip 1 - Yaroslavl and Ivan/data/normal.jpg",
                              redImagePath: "https://dynamic.theskinnyonbenny.com/gal/031 - Russia Trip 1 - Yaroslavl and Ivan/data/red.jpg"),
        32: FromDynamicLookup(name: "Russia Trip 1 - Moscow",
                              normalImagePath: "https://dynamic.theskinnyonbenny.com/gal/032 - Russia Trip 1 - Moscow/data/normal.jpg",
                              redImagePath: "https://dynamic.theskinnyonbenny.com/gal/032 - Russia Trip 1 - Moscow/data/red.jpg"),
        33: FromDynamicLookup(name: "Russia Trip 2 - Week 1",
                              normalImagePath: "https://dynamic.theskinnyonbenny.com/gal/033 - Russia Trip 2 - Week 1/data/normal.jpg",
                              redImagePath: "https://dynamic.theskinnyonbenny.com/gal/033 - Russia Trip 2 - Week 1/data/red.jpg"),
        34: FromDynamicLookup(name: "Russia Trip 2 - St. Petersburg",
                              normalImagePath: "https://dynamic.theskinnyonbenny.com/gal/034 - Russia Trip 2 - St. Petersburg/data/normal.jpg",
                              redImagePath: "https://dynamic.theskinnyonbenny.com/gal/034 - Russia Trip 2 - St. Petersburg/data/red.jpg"),
        35: FromDynamicLookup(name: "Russia Trip 2 - Back in Yaroslavl",
                              normalImagePath: "https://dynamic.theskinnyonbenny.com/gal/035 - Russia Trip 2 - Back in Yaroslavl/data/normal.jpg",
                              redImagePath: "https://dynamic.theskinnyonbenny.com/gal/035 - Russia Trip 2 - Back in Yaroslavl/data/red.jpg"),
        36: FromDynamicLookup(name: "Russia Trip 2 - Final Week Family and Baby Photos",
                              normalImagePath: "https://dynamic.theskinnyonbenny.com/gal/036 - Russia Trip 2 - Final Week Family and Baby Photos/data/normal.jpg",
                              redImagePath: "https://dynamic.theskinnyonbenny.com/gal/036 - Russia Trip 2 - Final Week Family and Baby Photos/data/red.jpg"),
        78: FromDynamicLookup(name: "Short Russia Trip to Meet Kolya",
                              normalImagePath: "https://dynamic.theskinnyonbenny.com/gal/078 - Short Russia Trip to Meet Kolya/data/normal.jpg",
                              redImagePath: "https://dynamic.theskinnyonbenny.com/gal/078 - Short Russia Trip to Meet Kolya/data/red.jpg"),
        81: FromDynamicLookup(name: "Russia - Yaroslavl Wk 2 and St Petersburg",
                              normalImagePath: "https://dynamic.theskinnyonbenny.com/gal/081 - Russia - Yaroslavl Wk 2 and St Petersburg/data/normal.jpg",
                              redImagePath: "https://dynamic.theskinnyonbenny.com/gal/081 - Russia - Yaroslavl Wk 2 and St Petersburg/data/red.jpg"),
        82: FromDynamicLookup(name:"Russia - Gotcha Day and the Next Day",
                              normalImagePath: "https://dynamic.theskinnyonbenny.com/gal/082 - Russia - Gotcha Day and the Next Day/data/normal.jpg",
                              redImagePath: "https://dynamic.theskinnyonbenny.com/gal/082 - Russia - Gotcha Day and the Next Day/data/red.jpg"),
        83: FromDynamicLookup(name: "Russia - Last Days in Moscow",
                              normalImagePath: "https://dynamic.theskinnyonbenny.com/gal/083 - Russia - Last Days in Moscow/data/normal.jpg",
                              redImagePath: "https://dynamic.theskinnyonbenny.com/gal/083 - Russia - Last Days in Moscow/data/red.jpg")
    ]
}



