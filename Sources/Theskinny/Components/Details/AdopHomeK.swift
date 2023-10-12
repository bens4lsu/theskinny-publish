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
        let path =  context.site.path(for: .home).parent + "Content-custom/adopHomeK.md"
        
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
        let imageGalSet1 = ImageGalleryLinkSet(78)
        let imageGalSet2 = ImageGalleryLinkSet(81, 82, 83)
        
        let vgLink1 = VideoGalleryLink(url: "/video/kolya-at-his-orphanage", image: "mq1p.jpg", caption: "Orphanage Visit 1")
        let vgLink2 = VideoGalleryLink(url: "/video/kolya-at-his-orphanage-2", image: "mq3j.jpg", caption: "Orphanage Visit 1")
        let vgSet1 = VideoGalleryLinkSet(links: [vgLink1, vgLink2])
        let vgLink3 = VideoGalleryLink(url: "/video/hotel-play-first-night-with-kolya/", image: "mq3h.jpg", caption: "Hotel Play, First Night with Kolya")
        let vgLink4 = VideoGalleryLink(url: "/video/last-video-of-us-in-the-orphange-play-room/", image: "mq2k.jpg", caption: "Another Orphanage Visit Video")
        let vgSet2 = VideoGalleryLinkSet(links: [vgLink3, vgLink4])
        
        return Article {
            H1("Kolya's Adoption")
            H2("Referral and First Trip")
            self.tripOneLinks
            H2("First Trip Photos")
            imageGalSet1
            H2("Video Form Our First Visit to the Orpahange")
            vgSet1
            H2("Between Trips")
            self.betweenTripsLinks
            H2("Trip Two")
            self.tripTwoLinks
            H2("Trip Two Pictures")
            imageGalSet2
            H2("Trip Two Video")
            vgSet2
            imageGalSet1.scripts
            imageGalSet2.scripts
            Text("More videos from the trip are posted ")
            Link("here", url: "/video-albums/family-videos-from-russia-2012")
            Text(".")
        }
    }
}
