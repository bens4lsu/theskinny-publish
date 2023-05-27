//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/27/23.
//

import Foundation
import Publish
import Plot


enum AdopVSection {
    case preliminaries
    case tripOne
    case betweenTrips
    case tripTwo
    case home
}

struct AdopVItem: Component {
    var title: String
    var date: Date
    var section: AdopVSection
    var content: Content.Body
    var slug: String
    
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


struct AdopV: Component {
    
    var items: [AdopVItem]
    
    var prelimLinks: List<[AdopVItem]> { listItemsForSection(.preliminaries) }
    var tripOneLinks: List<[AdopVItem]> { listItemsForSection(.tripOne) }
    var betweenTripsLinks:  List<[AdopVItem]> { listItemsForSection(.betweenTrips) }
    var tripTwoLinks:  List<[AdopVItem]> { listItemsForSection(.tripTwo) }
    var lastLink:  List<[AdopVItem]> { listItemsForSection(.home) }
    
    var body: Component {
        return Article {
            H1("Vanya's Adoption")
            Text("I started this page in April 2006, long before we had told most of our friends and family what was going on. That didn't stop us from accumulating stories about the process that deserve to be told, so I kept track of some of the milestones throughout the process. Hopefully, it proves to be interesting or entertaining. Or at least compels you toward a little compassion.")
            H2("The Preliminaries")
            prelimLinks
            H2("Trip One")
            tripOneLinks
            H2("Photos From Trip One")
            Text("Click on a picture to see the entire collection")
            H2("Between Trips")
            betweenTripsLinks
            H2("Trip 2")
            tripTwoLinks
            H2("Photos From Trip Two")
            H2("Home Sweet Home")
            lastLink
        }
    }
    
    private func listItemsForSection(_ section: AdopVSection) -> List<[AdopVItem]> {
        let sectionItems = items.filter { $0.section == section }
        
        return List(sectionItems) { item in
            ListItem {
                Link("\(item.dateString):  \(item.title)", url: "/adopV/\(item.slug)")
            }
        }
    }
}
