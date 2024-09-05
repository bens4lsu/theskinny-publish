//
//  Date.swift
//  MastodonGetter
//
//  Created by Ben Schultz on 2024-09-04.
//

import Foundation

extension Date {
    var year: Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let string = formatter.string(from: self)
        return Int(string)!
    }
}
