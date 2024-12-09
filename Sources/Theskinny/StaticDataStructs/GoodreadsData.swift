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


class GoodreadsData {
    
    enum GoodreadsHowConsumed {
        case book
        case audiobook
    }
    
    struct GoodreadsBook {
        let bookId: Int
        let title: String
        let author: String
        let myRating: UInt8?
        let dateRead: Date
        let howConsumed: GoodreadsHowConsumed
    }
    
    private static let file = try? File(path: "./Content-custom/goodreads_library_export.csv")
    static let fileDate = file?.creationDate ?? Date()
    
    static let books: [GoodreadsBook] = {
        
   
        
        
        guard let file,
              let csv = try? CSV<Named>(string: file.readAsString())
        else {
            return []
        }

        var books = [GoodreadsBook]()
        for row in csv.rows {
                        
            var howConsumed: GoodreadsHowConsumed? = nil
            if row["Exclusive Shelf"] == "read" {
                howConsumed = .book
            }
            else if row["Exclusive Shelf"] == "audiobooks-listened" {
                howConsumed = .audiobook
            }
                        
            if let bookIdString = row["Book Id"],
               let bookId = Int(bookIdString),
               let title = row["Title"],
               let author = row["Author"],
               let howConsumed = howConsumed,
               let dateString = row["Date Read"],
               let date = EnvironmentKey.formatteryyyyMMddWithSlashes.date(from: dateString),
               let ratingString = row["My Rating"]
            {
                let book = GoodreadsBook(bookId: bookId,
                                         title: title,
                                         author: author,
                                         myRating: UInt8(ratingString),
                                         dateRead: date,
                                         howConsumed: howConsumed)
                books.append(book)
            }
        }
        return books
    }()
}
