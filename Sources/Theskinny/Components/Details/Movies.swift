//
//  File.swift
//  Theskinny
//
//  Created by Ben Schultz on 2025-01-15.
//

import Foundation
import Plot
import Publish


struct Movie: Component {
    let lbmovie: LetterboxdData.LetterboxdMovie
    
//    var dateRead: String {
//        EnvironmentKey.defaultDateFormatter.string(from: lbmo.dateRead)
//    }
    
    
    
    var stars: String {
        guard let rating = lbmovie.rating else {
            return ""
        }
        let wholePart = Int(rating.rounded(.down))
        let decimalPart = Int((rating.truncatingRemainder(dividingBy: 1) * 10).rounded(.down))
        let halfStars = decimalPart == 5 ? "½" : ""
        
        return String(repeating: "⭐️", count: wholePart) + halfStars
    }
    
    var body: Component {
        Div {
            H3 (lbmovie.dateWatched)
            Div(Link(lbmovie.title, url: lbmovie.letterboxdUrl)).class("book-title")
            Div (stars)
        }
    }
}


struct Movies: Component {
    
    var lastUpdateDate: String {
        EnvironmentKey.defaultDateFormatter.string(from: LetterboxdData.fileDate)
    }
    
    var body: Component {
        Div {
            Div {
                H1("Movies Watched")
                Div ("I really don't watch that many movies, and then I forget to log some of them that I do watch.  But here's what I logged, at least.").class("pg-instruction-box caption")
                H3("Watch list last updated \(lastUpdateDate).  ")
            }
            Div {
                List(LetterboxdData.movies){ movie in
                    Movie(lbmovie: movie)
                }.listStyle(.listOfFlexItems)
            }.class("books-div-flex micro-post-parent-container")
        }
    }
}
