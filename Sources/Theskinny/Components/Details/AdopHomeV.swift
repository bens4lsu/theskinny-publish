//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/27/23.
//

import Foundation
import Publish
import Plot
import Files


struct AdopHomeV: Component {
    // V side of AdopHome
    
    var context: PublishingContext<Theskinny>
    
    var content: Component  {
        let path =  context.site.path(for: .home).parent + "Content-custom/adopHomeV.md"
        
        let file = try? File(path: path)
        let string = (try? file?.readAsString()) ?? ""
        return Markdown(string) 
    }
    
    
    init(_ context: PublishingContext<Theskinny>) {
        self.context = context
    }
    
    var body: Component {
        Div {
            content
        }.class("div-adop-v")
    }
}

class AdopV: AdopGeneral, Component {
    // Index screen for V
    
    var body: Component {
        let imgGalSet1 = ImageGalleryLinkSet(31, 32)
        let imgGalSet2 = ImageGalleryLinkSet(33, 34, 35, 36)
        //let imgGalSet3 = ImageGalleryLinkSet (35, 36)
        
        return Article {
            H1("Vanya's Adoption")
            Text("I started this page in April 2006, long before we had told most of our friends and family what was going on. That didn't stop us from accumulating stories about the process that deserve to be told, so I kept track of some of the milestones throughout the process. Hopefully, it proves to be interesting or entertaining. Or at least compels you toward a little compassion.")
            H2("The Preliminaries")
            self.prelimLinks
            H2("Trip One")
            self.tripOneLinks
            H2("Photos From Trip One")
            imgGalSet1
            H2("Between Trips (click to open)")
            self.betweenTripsLinks
            H2("Trip Two")
            self.tripTwoLinks
            H2("Photos From Trip Two")
            imgGalSet2
            //imgGalSet3
            H2("Home Sweet Home")
            self.lastLink
            imgGalSet1.jsAll
            imgGalSet2.jsImageVariables
            //imgGalSet3.jsImageVariables
        }
    }
}
