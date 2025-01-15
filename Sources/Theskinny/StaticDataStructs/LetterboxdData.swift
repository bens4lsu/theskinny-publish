//
//  File.swift
//  Theskinny
//
//  Created by Ben Schultz on 2024-12-09.
//

import Foundation
import Files
import SwiftCSV
import Plot


class LetterboxdData {
    
    struct LetterboxdMovie: Comparable {
        
        let dateWatched: String
        let title: String
        let year: String
        let rating: Float?
        let letterboxdUrl: String
        
        static func < (lhs: LetterboxdData.LetterboxdMovie, rhs: LetterboxdData.LetterboxdMovie) -> Bool {
            // reverse sort (intentional)
            rhs.dateWatched < lhs.dateWatched
        }
    }
    
    private static let file = try? File(path: "./Content-custom/letterboxd_diary.csv")
    static let fileDate = file?.creationDate ?? Date()
    

    
    static let movies: [LetterboxdMovie] = {
    
        guard let file,
              let csv = try? CSV<Named>(string: file.readAsString())
        else {
            return []
        }

        var movies = [LetterboxdMovie]()
        for row in csv.rows {
            if let dateWatched = row["Watched Date"],
               let title = row["Name"],
               let year = row["Year"],
               let letterboxdUrl = row["Letterboxd URI"],
               let ratingString = row["Rating"]
            {
                if !(row["Rewatch"] == "Yes") {
                    let rating = Float(ratingString)
                    let movie = LetterboxdMovie(dateWatched: dateWatched, title: title, year: year, rating: rating, letterboxdUrl: letterboxdUrl)
                    movies.append(movie)
                }
            }
        }
        return movies.sorted()
    }()
}
