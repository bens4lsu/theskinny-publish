//
//  File.swift
//  
//
//  Created by Ben Schultz on 2024-08-19.
//

import Foundation
import Plot
import Publish



struct DailyPhoto: Component, Comparable {

    //let imagePath: String
    let caption: String
    let month: UInt8
    let day: UInt8
    let year: UInt16
    
    var prevLink: String?
    var nextLink: String?
    
    var link: String {
        "/dailyphoto/\(year)/\(year)\(month.zeroPadded(2))\(day.zeroPadded(2))"
    }
    
    var imagePath: String {
        "/dailyphotostore/\(year)/\(year)\(month.zeroPadded(2))\(day.zeroPadded(2)).jpg"
    }
    
    var dateString: String {
        let yyyyMMdd = "\(year.zeroPadded(4))\(month.zeroPadded(2))\(day.zeroPadded(2))"
        let date = EnvironmentKey.yyyyMMddDateFormatter.date(from: yyyyMMdd) ?? Date()
        let str = EnvironmentKey.defaultDateFormatter.string(from: date)
        return str
    }
    
    var topLinks: TopNavLinks {
        var prevLinkInfo: LinkInfo? = nil
        var nextLinkInfo: LinkInfo? = nil
        if let prevLink {
            prevLinkInfo = LinkInfo("Previous", prevLink)
        }
        if let nextLink {
            nextLinkInfo = LinkInfo("Next", nextLink)
        }
        return TopNavLinks(prevLinkInfo, nil, nextLinkInfo)
    }
    
    var body: Component {
        Div {
            topLinks
            H3(dateString)
            Div {
                Paragraph(caption).class("dailyphotocaption")
                Image(imagePath).class("dailyphotoimage")
            }.class("dailyphototop")
            DailyPhotoCalendar.YearTable(year: year, selectedMonth: month, selectedDay: day)
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




