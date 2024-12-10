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
    
    var prevMonthLink: String?
    var nextMonthLink: String?
    
    var link: String {
        "/dailyphoto/\(year)/\(year)\(month.zeroPadded(2))\(day.zeroPadded(2))"
    }
    
    var imagePath: String {
        "/dailyphotostore/\(year)/\(year)\(month.zeroPadded(2))\(day.zeroPadded(2)).jpg"
    }
    
    var yyyyMMdd: String {
        "\(year.zeroPadded(4))-\(month.zeroPadded(2))-\(day.zeroPadded(2))"
    }
    
    var dateString: String {
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
    
    var monthLinks: TopNavLinks {
        var prevMonthInfo: LinkInfo? = nil
        var nextMonthInfo: LinkInfo? = nil
        if let previous = DailyPhotoData.monthLink(forYear: year, month: month, direction: .previous) {
            prevMonthInfo = LinkInfo("Previous Month", previous)
        }
        if let next = DailyPhotoData.monthLink(forYear: year, month: month, direction: .next) {
            nextMonthInfo = LinkInfo("Next Month", next)
        }
        return TopNavLinks(prevMonthInfo, nil, nextMonthInfo)
    }
    
    var body: Component {
        let littleMonthTable = DailyPhotoCalendar.MonthTable(month: month, year: year, selectedMonth: month, selectedDay: day)
        
        return  Div {
            topLinks
            H3(dateString)
            Div {
                Paragraph(Markdown(caption)).class("dailyphotocaption")
                Image(imagePath).class("dailyphotoimage")
            }.class("dailyphototop")
            DailyPhotoCalendar.YearTable(year: year, selectedMonth: month, selectedDay: day).class("dailyphoto-big-cal")
            
            Div {
                Div {
                    Text(littleMonthTable.monthName)
                    littleMonthTable
                }.class("dailyphoto-little-cal-inner-box")
                monthLinks
            }.class("dailyphoto-little-cal")

            Div {
                H3("Other years:")
                
                List {
                    ComponentGroup(members: DailyPhotoData.allYearLinks(except: year))
                }.listStyle(.inlineListOfLinks)
            }.class("dailyphoto-otheryears")
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




