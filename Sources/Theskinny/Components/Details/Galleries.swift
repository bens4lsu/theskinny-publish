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


struct Galleries: Component {
    
    var list: [Gallery]
    var showInstructions: Bool = true
    
    
    init(list: [Gallery]) {
        // used for ImageGalleryLink -- gallery links in other pages
        self.list = list
        self.showInstructions = false
    }
    
    init() {
        self.list = ImageGalleryData.imageGalleries
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
    
    var instructions: Component {
        if showInstructions {
            return ComponentGroup {
                H2("The Photo Collections...")
                Paragraph("Click on any of the pictures in this part of the page to open the whole set of photos for that collection.  If this is your first trip in, give it a minute.  It may take this page a little while to load all of the pictures, but I like having one big giant list of my photo albums in one place.")
            }
        }
        else {
            return EmptyComponent()
        }
    }
    
    var body: Component {
        let cells = list.map { $0.cell }
        return ComponentGroup {
            scripts
            Div {
                instructions
                Div {
                    ComponentGroup(members: cells)
                }.class("pg-grid")
            }
        }
    }
}
