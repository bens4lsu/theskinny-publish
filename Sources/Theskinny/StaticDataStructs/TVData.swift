//
//  File.swift
//  Theskinny
//
//  Created by Ben Schultz on 2025-01-16.
//

import Foundation
import Files
import SwiftCSV
import Plot


class TVData {
    
    class Series: Comparable {
        
        let dateFinished: String
        let title: String
        let type: String
        let rating: Float
        let summary: String
        
        init(dateFinished: String, title: String, type: String, rating: Float, summary: String) {
            self.dateFinished = dateFinished
            self.title = title
            self.type = type
            self.rating = rating
            self.summary = summary
        }
        
        static func < (lhs: TVData.Series, rhs: TVData.Series) -> Bool {
            // reverse sort (intentional)
            rhs.dateFinished < lhs.dateFinished
        }
        
        static func == (lhs: TVData.Series, rhs: TVData.Series) -> Bool {
            // reverse sort (intentional)
            rhs.dateFinished == lhs.dateFinished
        }
    }
    
    private static let file = try? File(path: "./Content-custom/tv.txt")
    static let fileDate = file?.creationDate ?? Date()
    

    
    static let series: [Series] = {
    
        guard let file,
              let csv = try? CSV<Named>(string: file.readAsString(), delimiter: .tab)
        else {
            return []
        }

        var allSeries = [Series]()
        for row in csv.rows {
            if let title = row["Title"],
               let type = row["Type"],
               let summary = row["Summary"],
               let dateFinished = row["Date Finished"],
               let ratingString = row["Rating"],
               let rating = Float(ratingString)
            {
                let series = Series(dateFinished: dateFinished, title: title, type: type, rating: rating, summary: summary)
                allSeries.append(series)
    
            }
        }
        return allSeries.sorted()
    }()
}
