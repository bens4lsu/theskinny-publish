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
        return formatter
    }()
    
    static let hmsDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy hh:mm:ss"
        return formatter
    }()
    
    static let yyyyMMddDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

}

extension EnvironmentKey where Value == Int {
    static let blogPostsPerPage = 12
    //static let styleAndScriptVersion = Int.random(in: Int.min...Int.max)
    static let styleAndScriptVersion = 1023
}

extension EnvironmentKey where Value == String {
    static let emptyImg = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+P+/HgAFhAJ/wlseKgAAAABJRU5ErkJggg=="
    
    static let predictWindSrc = "https://forecast.predictwind.com/tracking/display/VelvetElvis/?mapMode=useAtlas&windSymbol=OFF&weatherSource=ECMWF&trackDuration=31536000"
}
