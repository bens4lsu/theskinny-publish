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
    // for anything other than pgHome.  When you want to
    // drop links to a gallery in somewhere
    
    private var thisGallerySet: Galleries
    
    init(_ ids: Int...) {
        let links = ids.compactMap { id in
            try? Gallery(id)
        }
        self.thisGallerySet = Galleries(list: links)
    }
    
    var body: Component {
        thisGallerySet
    }
        
    var scripts: Component {
        thisGallerySet.scripts
    }
    
}

