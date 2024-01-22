//
//  File.swift
//  
//
//  Created by Ben Schultz on 2024-01-22.
//

import Foundation

enum BlogRoot: String {
    case blog2 = "/blog2/"
    case bigtrip = "/big-trip/"
    
    var index: String {
        switch self {
        case .blog2:
            "/blog/current/"
        case .bigtrip:
            "/big-trip/"
        }
        
    }
}
