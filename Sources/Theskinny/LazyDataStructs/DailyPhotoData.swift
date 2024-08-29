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
}


struct DailyPhotoYear: Comparable {
    var dp = [DailyPhoto]()
    var year: UInt16
    
    var prevYearLink: String?
    var nextYearLink: String?
    
    var link: String

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
                let yearRedirectPath = "/dailyphoto/\(folder.name)/index.html"
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
            years[i].prevYearLink = prevYear?.link
            years[i].nextYearLink = nextYear?.link
            
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
                years[i].dp[j].nextLink = nextSlide?.link
                years[i].dp[j].prevLink = prevSlide?.link
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
    
    static func allYearLinks(except yearToOmit: UInt16) -> [Component] {
        return Self.allYearLinks.filter { link in
            link.0 != yearToOmit.zeroPadded(4)
        }.map { item in
            item.1
        }
    }
    
   
    static var lastDayString: String {
        guard let dp = Self.years.last?.dp.last else {
            return ""
        }
        return "\(dp.year.zeroPadded(4))\(dp.month.zeroPadded(2))\(dp.day.zeroPadded(2))"
    }
    
    static var scriptCommon: String {
        """
            function dpPath() {
                var today = function() {
                    var x = new Date();
                    var y = x.getFullYear().toString();
                    var m = (x.getMonth() + 1).toString();
                    var d = x.getDate().toString();
                    d = ('0' + d).substring(d.length - 2);
                    m = ('0' + m).substring(m.length - 2);
                    var yyyymmdd = y + m + d;
                    return yyyymmdd;
                }();
            
                var latest = \"\(lastDayString)\";
            
                var winner = today < latest ? today : latest;
                var pathPart = "/" + winner.toString().substring(0,4) + "/" + winner;
                return pathPart
            }
        """
    }
    
    static var scriptImage: String {
        scriptCommon + 
        """
            
            var dailyphotoImg = "/dailyphotostore" + dpPath() + ".jpg";
            var i = document.getElementById(\"homeDPImage\");
            i.src = dailyphotoImg;

        """
    }
    
    static var scriptRedirect: String {
        scriptCommon +
        """
            
            var dailyphotoRedirect = "/dailyphoto" + dpPath();
            window.location.replace(dailyphotoRedirect);

        """
    }
}
