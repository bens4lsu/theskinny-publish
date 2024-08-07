//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/18/23.
//

import Foundation
import Plot
import Publish

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

}

extension EnvironmentKey where Value == Int {
    static let blogPostsPerPage = 12
    //static let styleAndScriptVersion = Int.random(in: Int.min...Int.max)
    static let styleAndScriptVersion = 1025
}

extension EnvironmentKey where Value == String {
    static let emptyImg = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+P+/HgAFhAJ/wlseKgAAAABJRU5ErkJggg=="
    
    static let predictWindSrc = "https://forecast.predictwind.com/tracking/display/VelvetElvis/?mapMode=useAtlas&windSymbol=OFF&weatherSource=ECMWF&trackDuration=31536000"
}

extension EnvironmentKey where Value == [Int] {
    static let hideGalleryIDs: [Int] = []
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
            try? Gallery(191, dateString: "2024-08-09")
        ].compactMap{ $0 }
        return pgSet
    }()
}
