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
    case unfiled
}

struct AdopItem: Component {
    var title: String
    var date: Date
    var section: AdopSection
    var content: Content.Body
    var slug: String
    var siteSection: Section<Theskinny>
    var linkToPrev: LinkInfo?
    var linkToIndex: LinkInfo?
    var linkToNext: LinkInfo?
    
    
    var dateString: String {
        EnvironmentKey.defaultDateFormatter.string(from: date)
    }
    
    var subfolder: String {
        let path = Path(slug)
        return "/" + path.parent()
    }
    
    var body: Component {
        Article {
            TopNavLinks(self.linkToPrev, self.linkToIndex, self.linkToNext)
            H1(title)
            H3(dateString)
            Div(content.body)
        }
    }
    
    init(title: String, date: Date, section sectionStr: String, content: Content.Body, slug: String, siteSection: Section<Theskinny> ) {
        self.title = title
        self.date = date
        self.content = content
        self.slug = slug
        self.siteSection = siteSection
        
        self.section = AdopSection(rawValue: sectionStr)  ?? .unfiled
    }
}


class AdopGeneral {
    
    var items: [AdopItem]
        
    var prelimLinks: Component { listItemsForSection(.preliminaries) }
    var tripOneLinks: Component { listItemsForSection(.tripOne) }
    var betweenTripsLinks:  Component { listItemsForSection(.betweenTrips) }
    var tripTwoLinks:  Component { listItemsForSection(.tripTwo) }
    var lastLink:  Component { listItemsForSection(.home) }
    
    var adopV: Component {
        let filteredItems = items.filter({ $0.siteSection.id == .adopv })
            .sorted(by: {$0.date < $1.date })
        return AdopV(items: filteredItems)
    }
    
    var adopK: Component {
        let filteredItems = items.filter({ $0.siteSection.id == .adopk })
            .sorted(by: { $0.date < $1.date })
        return AdopK(items: filteredItems)
    }
 
    init(items: [AdopItem]) {
        self.items = items.sorted(by: { $0.date < $1.date })
    }
    
    func post(withSlug slug: String) -> AdopItem? {
        guard let item = items.first(where: { $0.slug == slug }) else {
            return nil
        }
        let folder = item.subfolder
        let itemSubset = items.filter( {$0.subfolder == folder })
        
        guard let i = itemSubset.firstIndex(where: { $0.slug == item.slug }) else {
            return nil
        }
        
        var post = itemSubset[i]
        if i != 0 {
            post.linkToPrev = LinkInfo(text: itemSubset[i-1].title, url: "/\(itemSubset[i-1].slug)")
        }
        if i < itemSubset.count - 1 {
            post.linkToNext = LinkInfo(text: itemSubset[i+1].title, url: "/\(itemSubset[i+1].slug)")
        }
        post.linkToIndex = LinkInfo(text: "Story Index", url: folder)
        return post
    }
    

    
    private func listItemsForSection(_ section: AdopSection) -> Component {
        let sectionItems = items.filter { $0.section == section }
        
        let listStyle = HTMLListStyle(elementName: "") { listItem in
            Div(listItem).class("list-of-links")
        }
        
        let list = List(sectionItems) { item in
            Link("\(item.dateString):  \(item.title)", url: "/\(item.slug)")
        }.listStyle(listStyle)
        
        return list
    }
}




    

