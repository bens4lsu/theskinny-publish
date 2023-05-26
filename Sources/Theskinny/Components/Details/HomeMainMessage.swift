//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/25/23.
//

import Foundation
import Publish
import Plot
import Files

struct HomeMainMessage: Component {
    
    var context: PublishingContext<Theskinny>
    
    var content: String?  {
        let path =  context.site.imagePath
        let folder = try? Folder(path: path?.string ?? "")
        
        let file = try? File(path: folder?.path ?? "" + "homeMain.txt")
        let string = try? file?.readAsString()
        print(string)
        return string
    }
    
    
    init(_ context: PublishingContext<Theskinny>) {
        self.context = context
    }
    
    
    
    var body: Component {
        Div {
            Text(content ?? "")
        }.class("div-home-main-mess")
    }
}
