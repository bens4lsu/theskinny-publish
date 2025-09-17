//
//  File.swift
//  Theskinny
//
//  Created by Ben Schultz on 2024-12-09.
//

import Foundation
import Plot
import Publish


struct Book: Component {
    let grbook: GoodreadsData.GoodreadsBook
    
    var dateRead: String {
        EnvironmentKey.defaultDateFormatter.string(from: grbook.dateRead)
    }
    
    var stars: String {
        guard let rating = grbook.myRating else {
            return ""
        }
        return .init(repeating: "⭐️", count: Int(rating))
    }
    
    var audiobookIndicator: Component {
        if let ind = grbook.howConsumed.audiobookIndicator {
            return Div(ind)
        }
        return EmptyComponent()
    }
    
    var body: Component {
        Div {
            H3 (dateRead)
            Div(grbook.title).class("book-title")
            audiobookIndicator
            Div(grbook.author)
            Div (stars)
            H3 (grbook.myReview ?? "")
        }
    }
}


struct Books: Component {
    
    var lastUpdateDate: String {
        EnvironmentKey.defaultDateFormatter.string(from: GoodreadsData.fileDate)
    }
    
    var body: Component {
        Div {
            Div {
                H1("What I've Read")
                Div ("Way back when, I occasionally started a book only to get 70 pages in and realize I knew the whole thing.  I had read it before.  I started tracking them on Goodreads, and this page just comes from a dump of my data over there.  If you're also on Goodreads, friend me.  Although I log them, I don't have the books that I bailed on listed here, so you won't see many low ratings.").class("pg-instruction-box caption")
                H3("Reading list last updated \(lastUpdateDate).  ")
            }
            Div {
                List(GoodreadsData.books){ book in
                    Book(grbook: book)
                }.listStyle(.listOfFlexItems)
            }.class("books-div-flex micro-post-parent-container")
        }
    }
}
