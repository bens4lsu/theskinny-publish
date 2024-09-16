//
//  File.swift
//  
//
//  Created by Ben Schultz on 2024-09-11.
//

import Foundation
import Plot
import Publish

struct BuildInstructions {
    
    enum DailyPhotoBuildType {
        case all
        case currentYear
        case none
    }
    
    static let dailyPhotoBuildType = DailyPhotoBuildType.all
    static let includeImageGalleries = true
    static let includeOldMicroPosts = true
    static let includeVideoAlbums = true
    static let includePosts = true
    
    
    static let currentYear = EnvironmentKey.formatterYYYY.string(from: Date())
    
    static var additionalCommands: [String] {
        var cmd = [String]()
        
        switch dailyPhotoBuildType {
        case .all:
            cmd.append ("")
        case .currentYear:
            cmd.append ("")
        case .none:
            cmd.append ("")
        }
    
        
        
        
        return cmd
    }
    
}
