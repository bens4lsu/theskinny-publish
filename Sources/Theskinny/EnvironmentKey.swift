//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/18/23.
//

import Foundation
import Plot
import Publish


enum DailyPhotoBuildMethod {
    case none
    case currentYear
    case all
}

extension EnvironmentKey where Value == DateFormatter {
    static let defaultDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        formatter.timeZone = .init(identifier: "UTC")
        return formatter
    }()
    
    static let hmsDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy hh:mm:ss"
        formatter.timeZone = .init(identifier: "UTC")
        return formatter
    }()
    
    static let yyyyMMddDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = .init(identifier: "UTC")
        return formatter
    }()
    
    static let formatterYYYY: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static let formatteryyyyMMddWithSlashes: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()

}

extension EnvironmentKey where Value == Int {
    static let blogPostsPerPage = 12
    //static let styleAndScriptVersion = Int.random(in: Int.min...Int.max)
    static let styleAndScriptVersion = 1041
    
    static let currentYear: Int = Calendar.current.component(.year, from: Date())
}

extension EnvironmentKey where Value == String {
    static let emptyImg = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+P+/HgAFhAJ/wlseKgAAAABJRU5ErkJggg=="
    
    static let predictWindSrc = "https://forecast.predictwind.com/tracking/display/VelvetElvis/?mapMode=useAtlas&windSymbol=OFF&weatherSource=ECMWF&trackDuration=31536000"
    
    static let appleMusicFilePath =  "/Users/ben/Library/CloudStorage/OneDrive-ConcordBusinessServices,LLC/itunes xml"
    
    static let googleMapsAPIKey = "AIzaSyAgaq2P3nwaEVsfOWNFRzcPcIpS4G0H5KA"
    static let bigtripMapKMZ = "https://theskinnyonbenny.com/bigtrip-actual.kml"
    //static let bigtripMapKMZ = "https://developers.google.com/maps/documentation/javascript/examples/kml/westcampus.kml"

}

extension EnvironmentKey where Value == [Gallery] {
    static let bigTripPGs = {
        let pgSet = [
            try? Gallery(181, dateString: "2024-01-29"),
            try? Gallery(182, dateString: "2024-02-21"),
            try? Gallery(183, dateString: "2024-03-09"),
            try? Gallery(184, dateString: "2024-04-17"),
            try? Gallery(185, dateString: "2024-04-18"),
            try? Gallery(186, dateString: "2024-05-29"),
            try? Gallery(187, dateString: "2024-07-11"),
            try? Gallery(188, dateString: "2024-07-14"),
            try? Gallery(189, dateString: "2024-07-15"),
            try? Gallery(190, dateString: "2024-07-27"),
            try? Gallery(191, dateString: "2024-08-09"),
            try? Gallery(192, dateString: "2024-08-15"),
            try? Gallery(193, dateString: "2024-09-03"),
        ].compactMap{ $0 }
        return pgSet
    }()
}



