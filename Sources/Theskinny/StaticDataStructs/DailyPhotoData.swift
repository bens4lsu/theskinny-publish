//
//  File.swift
//  
//
//  Created by Ben Schultz on 2024-08-23.
//

import Foundation
import Files
import Plot


enum DailyPhotoError: Error {
    case errorInFileName(name: String)
    case errorInFolderName(name: String)
    case fileOutOfPlace(_ text: String)
    case dpArrayOfYearsIsEmpty
}


class DailyPhotoYear: Comparable {
    var dp = [DailyPhoto]()
    var year: UInt16
    
    var prevYear: DailyPhotoYear?
    var nextYear: DailyPhotoYear?
    
    var link: String

    var first: DailyPhoto? {
        dp.sorted().first
    }
    
    var last: DailyPhoto? {
        dp.sorted().last
    }
    
    init (dp: [DailyPhoto], year: UInt16, link: String) {
        self.dp = dp
        self.year = year
        self.link = link
    }
    
    static func < (lhs: DailyPhotoYear, rhs: DailyPhotoYear) -> Bool {
        lhs.year < rhs.year
    }
    
    static func == (lhs: DailyPhotoYear, rhs: DailyPhotoYear) -> Bool {
        lhs.year < rhs.year
    }
}

enum MonthLinkDirection {
    case next
    case previous
}

struct DailyPhotoData {
    
    private static let dailyphotostore = "/Volumes/BenPortData/theskinny-media/dailyphotostore"

    static let years: [DailyPhotoYear] = {
            
        var years = [DailyPhotoYear]()
        let rootPath = dailyphotostore
        do {
            let topFolder = try Folder(path: rootPath)
            try topFolder.subfolders.forEach { folder in
                var dp = [DailyPhoto]()
                guard let year = UInt16(folder.name) else {
                    throw DailyPhotoError.errorInFolderName(name: folder.name)
                }
                try folder.files.forEach { file in
                    if file.extension == "jpg" {
                        guard let year = UInt16(file.name.substring(from: 0, to: 3)),
                              let month = UInt8(file.name.substring(from: 4, to: 5)),
                              let day = UInt8(file.name.substring(from: 6, to: 7))
                        else {
                            throw DailyPhotoError.errorInFileName(name: file.name)
                        }
                        
                        guard folder.name == year.zeroPadded(4) else {
                            throw DailyPhotoError.fileOutOfPlace("\(file.name) in folder \(year)")
                        }
                        
                        let captionFilePath = "\(rootPath)/\(folder.name)/\(year.zeroPadded(4))\(month.zeroPadded(2))\(day.zeroPadded(2)).txt"
                        var caption = ""
                        if let captionFile = try? File(path: captionFilePath) {
                            caption = try captionFile.readAsString()
                        }
                        dp.append(DailyPhoto(caption: caption, month: month, day: day, year: year))
                    }
                }
                // path to page where you can land and redirect to the first picture of the year
                let yearRedirectPath = "/dailyphoto/\(folder.name)"
                years.append(DailyPhotoYear(dp: dp, year: year, link: yearRedirectPath))
            }
        } catch (let e) {
            print ("Error loading daily photots: \(e)")
        }
        years.sort()
        
        // next and prev links
        for i in 0...years.count - 1 {
            var prevYear:DailyPhotoYear? = nil
            var nextYear:DailyPhotoYear? = nil
            if i < years.count - 1 {
                nextYear = years[i + 1]
            }
            if i > 0 {
                prevYear = years[i - 1]
            }
            years[i].prevYear = prevYear
            years[i].nextYear = nextYear
            
            years[i].dp.sort()
            for j in 0...years[i].dp.count - 1 {
                var nextSlide:DailyPhoto? = nil
                var prevSlide:DailyPhoto? = nil
                if j < years[i].dp.count - 1 {
                    nextSlide = years[i].dp[j + 1]
                }
                if j > 0 {
                    prevSlide = years[i].dp[j - 1]
                }
                years[i].dp[j].nextLink = nextSlide?.link ?? years[i].nextYear?.first?.link
                years[i].dp[j].prevLink = prevSlide?.link ?? years[i].prevYear?.last?.link
            }
        }
        return years
    }()
    
    
    
    static let allYearLinks: [(String, Component)] = {
        Self.years.map { item in
            let component = Div {
                Link(item.year.zeroPadded(4), url: item.link)
            }.class("dailyphotoDivOtherYear")
            
            return (item.year.zeroPadded(4), component )
        }
    }()
    
    static let allMonthLinks: [String: String] = {
        var tmp = [String: String]()
        for y in years {
            for dp in y.dp {
                let key = "\(dp.year.zeroPadded(4))\(dp.month.zeroPadded(2))"
                if tmp[key] == nil {
                    tmp[key] = dp.link
                }
            }
        }
        return tmp
    }()
    
    static let allMonthKeys: [String] = {
        allMonthLinks.map {$0.0}.sorted()
    }()
    
    static func allYearLinks(except yearToOmit: UInt16) -> [Component] {
        return Self.allYearLinks.filter { link in
            link.0 != yearToOmit.zeroPadded(4)
        }.map { item in
            item.1
        }
    }
    
    static func monthLink(forYear year: UInt16, month: UInt8, direction: MonthLinkDirection) -> String? {
        var linkKey = ""
        
        let lookup = year.zeroPadded(4) + month.zeroPadded(2)
        guard let index = allMonthKeys.firstIndex(of: lookup) else {
            return nil
        }
        
        switch direction {
        case .previous:
            if index > 0 {
                linkKey = allMonthKeys[index - 1]
            }
                
        case .next:
            if index < allMonthKeys.count - 1 {
                linkKey = allMonthKeys[index + 1]
            }
        }
        
        return allMonthLinks[linkKey]
    }
    

    
   
    
    // MARK: For generating Javascript redirects to the latest image/page
    
    static var latestYear: DailyPhotoYear {
        get throws {
            guard let latestDPYear = years.last?.year,
                  let thisYear = UInt16(EnvironmentKey.formatterYYYY.string(from: Date()))
            else {
                throw (DailyPhotoError.dpArrayOfYearsIsEmpty)
            }
            let yearToUse = thisYear < latestDPYear ? thisYear : latestDPYear
            return years.filter { $0.year == yearToUse}.first!
        }
    }
    
    static func allDatesFor(year yearObject: DailyPhotoYear) -> String {
        let yearStringsInArray = yearObject.dp.map { $0.yyyyMMdd }
        let encoder = JSONEncoder()
        let jsonString = String(data:try! encoder.encode(yearStringsInArray), encoding: .utf8)?
            .replacingOccurrences(of: "-", with: "")
        return jsonString ?? ""
    }
    
    static var lastDayString: String {
        guard let dp = Self.years.last?.dp.last else {
            return ""
        }
        return "\(dp.year.zeroPadded(4))\(dp.month.zeroPadded(2))\(dp.day.zeroPadded(2))"
    }
    
    // MARK: Script Strings
    
    static var javascriptCurrentDateString: String {
        """
            function dpPath() {
                var x = new Date();
                var y = x.getFullYear().toString();
                var m = (x.getMonth() + 1).toString();
                var d = x.getDate().toString();
                d = ('0' + d).substring(d.length - 1);
                m = ('0' + m).substring(m.length - 1);
                var yyyymmdd = y + m + d;
                return yyyymmdd;
            }
        """
    }
    
    static var scriptCommon: String {
        get throws {
            
            try javascriptCurrentDateString +
            """
            
                function dateToShow() {
                    let x = \(allDatesFor(year: latestYear)).filter((dt) => {
                        return dt <= dpPath();
                    });
                    return x.sort().pop();
                }
            
                function pathPart() {
                    let winner = dateToShow();

                    var pathPart = "/" + winner.toString().substring(0,4) + "/" + winner;
                    return pathPart
                }
            
                $(document).ready(function(){
            
                    var today = dpPath();
                    var latest = \"\(lastDayString)\";
            
                    var dailyphotoImg = "/dailyphotostore" + pathPart() + ".jpg";
                    $('#homeDPImage').attr('src', dailyphotoImg);
                });
                
            """
        }
    }
    
    static var scriptImage: String {
        get throws {
            try scriptCommon +
            """
            
                $(document).ready(function(){
                    var dailyphotoImg = "/dailyphotostore" + pathPart() + ".jpg";
                    $('#homeDPImage').attr('src', dailyphotoImg);
                });
            
            """
        }
    }
    
    static var scriptRedirect: String {
        get throws {
            try scriptCommon +
            """
                
                var dailyphotoRedirect = "/dailyphoto" + pathPart();
                window.location.replace(dailyphotoRedirect);
            
            """
        }
    }
    
    static var scriptCalendar: String {
        javascriptCurrentDateString +
        """
            $('.cell-with-link').each(function(i, elem) {
                let a = $(elem).children('a').first()
                let thisDate = a.attr('href').slice(-8);
                if (thisDate > dpPath()) {
                    let number = a.text();
                    a.replaceWith(number);
                    $(elem).removeClass();
                }
            });
            
            $('div.link-arrow-right').each(function(i, elem) {
                let childLinks = $(elem).children('a');
                for (let i = 0; i < childLinks.length; i++) {
                    let linkTo = $(childLinks[i]).attr('href').slice(-8);
                    if (linkTo > dpPath()) {
                       $(elem).remove();
                    }
                 }    
            });
        
        """
    }
    
    
}
