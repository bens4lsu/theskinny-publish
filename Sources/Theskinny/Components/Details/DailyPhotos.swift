//
//  File.swift
//  
//
//  Created by Ben Schultz on 2024-08-19.
//

import Foundation
import Plot
import Publish
import Ink
import Files

enum DailyPhotoError: Error {
    case errorInFileName
    case errorInFolderName
}


struct DailyPhoto: Component {
    
    let imagePath: String
    let caption: String
    let month: UInt8
    let day: UInt8
    let year: UInt16
    
    var body: Component {
        Div {
            Paragraph(caption)
            Image(imagePath)
        }
    }
}


struct DailyPhotoYear: Component {
    var dp = [DailyPhoto]()
    var year: UInt16
    
    var body: Component {
        EmptyComponent()
    }
}

