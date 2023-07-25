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
}

extension EnvironmentKey where Value == Int {
    static let blogPostsPerPage = 12
    //static let styleAndScriptVersion = Int.random(in: Int.min...Int.max)
    static let styleAndScriptVersion = 1006
}


