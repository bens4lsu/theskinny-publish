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
        let debug = self.list.map{ ($0.id, $0.column) }
        print(debug)
    }
    
    var body: Component {
        let leftGalleries = list.filter { $0.row != nil }
        let rows = leftGalleries.map { $0.row! }
        let cg: () -> ComponentGroup = { ComponentGroup(members: rows) }
        return Div {
            H2("The Photo Collections...")
            Paragraph("Click on any of the pictures in this part of the page to open the whole set of photos for that collection.  If this is your first trip in, give it a minute.  It may take this page a little while to load all of the pictures, but I like having one big giant list of my photo albums in one place.")
            Table(rows: cg)
                
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
    
    var body: Component {
        Div {
            TopNavLinks(LinkInfo("Back to List of Galleries", "/pgHome")
                        , nil
                        , nil)
            Markdown(html ?? "")
            List(images) { image in
                image.body(galRoot: imgRootPath)
            }
        }
    }
    
    var cell: TableCell {
        TableCell {
            Link(url: path){
                Image(normalImagePath).attribute(named: "name", value: "i\(id)").class("pgHome-imgage-link")
            }
        }//.class("pgHome-table-cell") as! TableCell
    }
    
    var row: TableRow? {
        guard let parent,
              let indexInParent else {
            return nil
        }
        guard indexInParent < parent.list.count - 2,
              column == .left
        else {
            return nil
        }
        let rightCell = parent.list[indexInParent + 1].cell
        
        return TableRow {
            self.cell
            rightCell
        }
    }

        
        
            
        
    /*
        <div style="float:right; background-color:#CDCDCD; border:2px solid #AD7070; width:280px; padding:7px;" class="datestamp">Picture Navigation: Click any thumbnail to open the full size image and caption.  When the full image appears, you can scroll to the next using left and right buttons to the corresponding side of the picture.  Your keyboard's arrow keys should also work, as will the scroll wheel on most computers.
            Picture Navigation: Click any thumbnail to open the full size image and caption.  When the full image appears, you can scroll to the next using left and right buttons to the corresponding side of the picture.  Your keyboard's arrow keys should also work, as will the scroll wheel on most computers.
        </div>

        
        #for(image in images):
            <a class="lightview" href="#(imgRootPath)#(image.imagePath)" data-lightview-caption="#(image.caption)" data-lightview-group="group1"><img src="#(imgRootPath)#(image.thumbnailpath)" alt="#(image.imagePath)"></a>
        #endfor

    */
}

struct GalleryImage: Component {
    var lineNum: Int
    var imagePath: String
    var thumbnailpath: String
    var caption: String
    
    var body: Component { EmptyComponent() }
    
    func body(galRoot: String) -> Component {
        Link(url: galRoot + imagePath){
            Image(url: galRoot + thumbnailpath, description: imagePath)
        }.class("lightview")
            .attribute(named: "data-lightview-caption", value: caption)
            .attribute(named: "data-lightview-group", value: "group1")
    }
}


