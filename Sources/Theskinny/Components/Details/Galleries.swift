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


enum GalleryHomePageColumn: String {
    case left
    case right
    case undetermined
}



class Galleries: Component {
    var list: [Gallery]
    
    init(list: [Gallery]) {
        // set which column the gallery should show up on on the main page
        self.list = list.sorted(by: { $0.id > $1.id })
        
        for i in 0..<list.count {
            if (self.list.count.isEven && i.isOdd) || (self.list.count.isOdd && i.isEven) {
                self.list[i].column = .left
            }
            else {
                self.list[i].column = .right
            }
            self.list[i].parent = self
            self.list[i].indexInParent = i
        }
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
        //let leftGalleries = list.filter { $0.row != nil }
        let cells = list.map { $0.cell }
        //let cg: () -> ComponentGroup = ComponentGroup(members: self.list)
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
    var column = GalleryHomePageColumn.undetermined
    weak var parent: Galleries?
    var indexInParent: Int?
    
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


