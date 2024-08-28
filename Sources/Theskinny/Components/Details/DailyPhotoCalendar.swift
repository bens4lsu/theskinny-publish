//
//  File.swift
//  
//
//  Created by Ben Schultz on 2024-08-28.
//

import Foundation
import Plot
import Publish


struct DailyPhotoCalendar {
    
    enum DayCell: Component {
        case empty
        case numbered(DayCellContent)
        
        var body: Component {
            switch self {
            case .empty:
                return EmptyCellContent()
            case .numbered(let content):
                return content
            }
        }
    }

    struct EmptyCellContent: Component {
        var body: Component {
            TableCell{
                EmptyComponent()
            }
        }
    }


    struct DayCellContent: Component {
        var dailyPhoto: DailyPhoto?
        var number: Int

        var isSelected: Bool
        
        var link: String? {
            dailyPhoto?.link
        }
        
        
        
        var body: Component {
            var cell: Component = TableCell{
                if let link {
                    Link(String(number), url: link)
                }
                else {
                    Text(String(number))
                }
            }
            
            if isSelected {
                cell = cell.class("cell-selected")            }
            
            if link != nil {
                cell = cell.class("cell-with-link")
            }
            
            return cell
        }
    }


    struct MonthTable: Component {
        
        static func makeDate(year: UInt16, month: UInt8, day: UInt8) -> Date {
            let calendar = Calendar(identifier: .gregorian)
            let components = DateComponents(year: Int(year), month: Int(month), day: Int(day))
            return calendar.date(from: components)!
        }
        
        var cells: [DayCell]
        var monthName: String
        var breakAfter: Bool
        var isLast: Bool
        var isCurrent: Bool
        
        init (month: UInt8, year: UInt16, selectedMonth: UInt8, selectedDay: UInt8) {
            
            //  cells gets initialized with 42 items, one for each day spot
            //  on the month table.
            
            let dt = Self.makeDate(year: year, month: month, day: 1)
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM"
            self.monthName = formatter.string(from: dt)
            
            self.breakAfter = month == 3 || month == 6 || month == 9
            self.isLast = month == 12
            
            formatter.dateFormat = "EEEE"
            let firstDOW = formatter.string(from: dt)
            let cellForFirst = firstDOW.dowToNumber()
            var dateComponent = DateComponents()
            dateComponent.month = 1
            dateComponent.day = -1
            let lastDayDt = Calendar.current.date(byAdding: dateComponent, to: dt)!
            formatter.dateFormat = "d"
            let lastDayInt = Int(formatter.string(from: lastDayDt))
            var table = [DayCell]()
            var currDay: Int? = nil
            for i in 1...42 {
                if currDay == nil && cellForFirst == i {
                    currDay = 1
                }
                else if currDay ?? -1 > lastDayInt! {
                    currDay = nil
                }
                if let day = currDay {
                   let dailyPhotoYear = DailyPhotoData.years
                        .filter { $0.year == year }
                        .first
                    let dp = dailyPhotoYear?.dp
                        .filter { $0.year == year && $0.month == month && $0.day == day }
                        .first
                    let isSelected = dp?.year == year && dp?.month == selectedMonth && dp?.day == selectedDay
                    let dayCellContent = DayCellContent(dailyPhoto: dp, number: day, isSelected: isSelected)
                    table.append(DayCell.numbered(dayCellContent))
                }
                else {
                    table.append(DayCell.empty)
                }
                if currDay != nil {
                    currDay! += 1
                }
            }
            cells = table
            isCurrent = month == selectedMonth
        }
        
        var body: Component {
            let topRow = TableRow {
                TableCell { Text("S") }.class("cell-dayofweek-heading")
                TableCell { Text("M") }.class("cell-dayofweek-heading")
                TableCell { Text("T") }.class("cell-dayofweek-heading")
                TableCell { Text("W") }.class("cell-dayofweek-heading")
                TableCell { Text("T") }.class("cell-dayofweek-heading")
                TableCell { Text("F") }.class("cell-dayofweek-heading")
                TableCell { Text("S") }.class("cell-dayofweek-heading")
            }
            var componentRows = [topRow]
            for row in 1...5 {
                var componentColumns = [DayCell]()
                for column in 1...7 {
                    let idx = (row - 1) * 7 + column - 1
                    componentColumns.append(cells[idx])
                }
                let componentRow = TableRow {
                    ComponentGroup(members: componentColumns)
                }
                componentRows.append(componentRow)
            }
            
            var table = Table {
                ComponentGroup(members: componentRows)
            }.class("littletable")
            
            if isCurrent {
                table = table.class("currentmonth")
            }
            
            return table
        }
    }

    struct YearTable: Component {
        var monthTables: [MonthTable]
        
        init(year: UInt16, selectedMonth: UInt8, selectedDay: UInt8) {
            var tableData = [MonthTable]()
            for i in 1...12 {
                tableData.append(MonthTable(month: UInt8(i) - 1, year: year, selectedMonth: selectedMonth, selectedDay: selectedDay))
            }
            self.monthTables = tableData
        }
        
        var body: Component {
            var componentRows = [TableRow]()
            for row in 1...4 {
                var componentColumns = [Component]()
                for column in 1...3 {
                    let idx = (row - 1) * 3 + column - 1
                    let monthTable = monthTables[idx]
                    let monthLabel = Text(monthTables[idx].monthName)
                    let cell = TableCell {
                        monthLabel
                        monthTable
                    }
                    componentColumns.append(cell)
                }
                let componentRow = TableRow {
                    ComponentGroup(members: componentColumns)
                }
                componentRows.append(componentRow)
            }
            
            return Table {
                ComponentGroup(members: componentRows)
            }.class("bigtable")
        }
    }

}
