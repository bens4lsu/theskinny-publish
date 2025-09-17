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
        
        var audiobookIndicator: String? {
            switch self {
            case .audiobook:
                return  "(audiobook)"
            default:
                return nil
            }
        }
    }
    
    class GoodreadsBook: Comparable {
        
        let bookId: Int
        let title: String
        let author: String
        let myRating: UInt8?
        let dateRead: Date
        let howConsumed: GoodreadsHowConsumed
        let myReview: String?
        
        init(bookId: Int, title: String, author: String, myRating: UInt8?, dateRead: Date, howConsumed: GoodreadsHowConsumed, myReview: String?) {
            self.bookId = bookId
            self.title = title
            self.author = author
            self.myRating = myRating
            self.dateRead = dateRead
            self.howConsumed = howConsumed
            self.myReview = myReview
        }
        
        static func < (lhs: GoodreadsData.GoodreadsBook, rhs: GoodreadsData.GoodreadsBook) -> Bool {
            // reverse sort (intentional)
            rhs.dateRead < lhs.dateRead
        }
        
        static func == (lhs: GoodreadsData.GoodreadsBook, rhs: GoodreadsData.GoodreadsBook) -> Bool {
            // reverse sort (intentional)
            rhs.dateRead == lhs.dateRead
        }
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
                                         howConsumed: howConsumed,
                                         myReview: row["My Review"]
                )
                books.append(book)
            }
        }
        return books.sorted()
    }()
}
