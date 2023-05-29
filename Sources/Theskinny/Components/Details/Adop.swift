//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/27/23.
//

import Foundation
import Publish
import Plot


enum AdopSection: String, Decodable {
    case preliminaries
    case tripOne
    case betweenTrips
    case tripTwo
    case home
}

struct AdopItem: Component {
    var title: String
    var date: Date
    var section: AdopSection
    var content: Content.Body
    var slug: String
    var siteSection: Section<Theskinny>
    
    var dateString: String {
        EnvironmentKey.defaultDateFormatter.string(from: date)
    }
    
    var body: Component {
        Article {
            H1(title)
            H3(dateString)
            Div(content.body)
        }
    }
}


class AdopGeneral {
    
    var items: [AdopItem]
        
    var prelimLinks: List<[AdopItem]> { listItemsForSection(.preliminaries) }
    var tripOneLinks: List<[AdopItem]> { listItemsForSection(.tripOne) }
    var betweenTripsLinks:  List<[AdopItem]> { listItemsForSection(.betweenTrips) }
    var tripTwoLinks:  List<[AdopItem]> { listItemsForSection(.tripTwo) }
    var lastLink:  List<[AdopItem]> { listItemsForSection(.home) }
    
    var adopV: Component {
        let filteredItems = items.filter({ $0.siteSection.id == .adopV })
        return AdopV(items: filteredItems)
    }
    
    var adopK: Component {
        let filteredItems = items.filter({ $0.siteSection.id == .adopK })
        return AdopV(items: filteredItems)
    }
 
    init(items: [AdopItem]) {
        self.items = items
    }
    
    private func listItemsForSection(_ section: AdopSection) -> List<[AdopItem]> {
        let sectionItems = items.filter { $0.section == section }
        
        return List(sectionItems) { item in
            ListItem {
                Link("\(item.dateString):  \(item.title)", url: "/adopV/\(item.slug)")
            }
        }
    }
}

class AdopV: AdopGeneral, Component {
    
    var body: Component {
        return Article {
            H1("Vanya's Adoption")
            Text("I started this page in April 2006, long before we had told most of our friends and family what was going on. That didn't stop us from accumulating stories about the process that deserve to be told, so I kept track of some of the milestones throughout the process. Hopefully, it proves to be interesting or entertaining. Or at least compels you toward a little compassion.")
            H2("The Preliminaries")
            self.prelimLinks
            H2("Trip One")
            self.tripOneLinks
            H2("Photos From Trip One")
            Text("Click on a picture to see the entire collection")
            H2("Between Trips")
            self.betweenTripsLinks
            H2("Trip Two")
            self.tripTwoLinks
            H2("Photos From Trip Two")
            H2("Home Sweet Home")
            self.lastLink
        }
    }
}

class AdopK: AdopGeneral, Component {
    
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
            self.tripOneLinks
            H2("Trip Two Pictures")
            H2("Trip Two Video")
            
            // TODO: Link album id 1730821
        }
    }
}

    

