//
//  File.swift
//  Theskinny
//
//  Created by Ben Schultz on 2025-01-16.
//

import Foundation
import Plot
import Publish

struct TVShow: Component {
    
    let show: TVData.Series
    
    var displayRating: String {
        let repeatCount = Int(show.rating)
        var ratingString = String(repeating: "⭐️", count: repeatCount)
        if show.rating > Float(Int(show.rating)) {
            ratingString += "½"
        }
        return ratingString
    }
    
    var body: Component {
        TableRow {
            TableCell { Text(show.title) }
            TableCell { Text(show.type) }
            TableCell { Text(show.summary) }
            TableCell { Text(show.dateFinished) }
            TableCell { Text(displayRating) }
        }
    }
    
    static var header = TableRow {
        TableHeaderCell { Text("Title") }
        TableHeaderCell { Text("Type") }
        TableHeaderCell { Text("Summary") }
        TableHeaderCell { Text("Date Finished") }
        TableHeaderCell { Text("Rating") }

    }
}

struct TVShows: Component {
    
    let series = TVData.series.map{ TVShow(show: $0) }
    let dateUpdated = TVData.fileDate
    let comment = "I watch a fair amount of TV.  I only log something if I finish a whole season, so there shouldn't be anything in htere that is too bad, unless it's also very short."
        
    var tableContents: Component {
        ComponentGroup(members: series)
    }
        
    var body: Component {
        Div {
            H1("TV Series Completed")
            H3("Updated \(dateUpdated)")
            Div(comment).class("pg-instruction-box caption")
            
            Div {
                Table(header: TVShow.header) {
                    tableContents
                }
            }.class("clear-both")
        }
    }
    

}
