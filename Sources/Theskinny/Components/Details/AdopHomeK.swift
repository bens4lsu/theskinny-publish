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


struct AdopHomeK: Component {
    // K side of Adop Home screen
    
    var context: PublishingContext<Theskinny>
    
    var content: Component  {
        let path =  context.site.path(for: .home).parent() + "Content-page-parts/adopHomeK.md"
        
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
        }.class("div-adop-k")
    }
}


class AdopK: AdopGeneral, Component {
    // Index screen for the K trips
    
    var body: Component {
        Article {
            H1("Kolya's Adoption")
            H2("Referral and First Trip")
            self.tripOneLinks
            H2("First Trip Photos")
            H2("Video Form Our First Visit to the Orpahange")
            H2("Between Trips")
            self.betweenTripsLinks
            H2("Trip Two")
            self.tripTwoLinks
            H2("Trip Two Pictures")
            H2("Trip Two Video")
            
            // TODO: Link album id 1730821
        }
    }
}
