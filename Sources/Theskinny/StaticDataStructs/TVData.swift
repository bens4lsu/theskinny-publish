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
        
        let dateFinished: Date
        let title: String
        let type: String
        let rating: Float
        let summary: String
        
        var dateFinishedString: String {
            EnvironmentKey.defaultDateFormatter.string(from: dateFinished)
        }
        
        init(dateFinished: Date, title: String, type: String, rating: Float, summary: String) {
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
    
    private static let file = try? File(path: "./Content-custom/tv.csv")
    static let fileDate = file?.creationDate ?? Date()
    
    
    
    static let series: [Series] = {
        
        do {
            guard let file else {
                print ("did not read tv.csv as file")
                return []
            }
            let csv = try CSV<Named>(string: file.readAsString(), delimiter: ",")
            var allSeries = [Series]()
            for row in csv.rows {
                if let title = row["Title"],
                   let type = row["Type"],
                   let summary = row["Summary"],
                   let dateFinishedString = row["Date Finished"],
                   let ratingString = row["Rating"],
                   let rating = Float(ratingString),
                   let dateFinished = EnvironmentKey.defaultDateFormatter.date(from: dateFinishedString)
                {
                    let series = Series(dateFinished: dateFinished, title: title, type: type, rating: rating, summary: summary)
                    allSeries.append(series)
                    
                }
                else if !(row["Title"] == "" && row["Type"] == "" && row["Summary"] == "" && row["Date Finished"] == "" && row["Rating"] == "") {
                    print ("Error reading row of TV data.  \(row)")
                }
                
            }
            return allSeries.sorted()
        }
        catch {
            print ("could not initialize CSV struct for TV \(error)")
            return []
        }
    
    }()
    
}
