//
//  File.swift
//  
//
//  Created by Ben Schultz on 2024-08-19.
//

import Foundation
import Plot
import Publish
import Ink
import Files

enum DailyPhotoError: Error {
    case errorInFileName
    case errorInFolderName
}





struct DailyPhoto: Component, Comparable {

    let imagePath: String
    let caption: String
    let month: UInt8
    let day: UInt8
    let year: UInt16
    
    var prevLink: String?
    var nextLink: String?
    
    var link: String {
        "dailyphoto/\(year)/\(year)\(month.zeroPadded(2))\(day.zeroPadded(2))"
    }
    
    var body: Component {
        Div {
            Paragraph(caption)
            Image(imagePath)
        }
    }
    
    static func < (lhs: DailyPhoto, rhs: DailyPhoto) -> Bool {
        if lhs.year == rhs.year {
            if lhs.month == rhs.month {
                return lhs.day < rhs.day
            }
            return lhs.month < rhs.month
        }
        return lhs.year < rhs.year
    }
}


struct DailyPhotoYear: Component, Equatable, Comparable {
    var dp = [DailyPhoto]()
    var year: UInt16
    
    
    var prevYearLink: String?
    var nextYearLink: String?
    
    var link: String? {
        dp.sorted().first?.link
    }
    
    var body: Component {
        EmptyComponent()
    }
    
    var first: DailyPhoto? {
        dp.sorted().first
    }
    
    var last: DailyPhoto? {
        dp.sorted().last
    }
    
    static func < (lhs: DailyPhotoYear, rhs: DailyPhotoYear) -> Bool {
        lhs.year < rhs.year
    }

}

