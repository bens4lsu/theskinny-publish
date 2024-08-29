//
//  File.swift
//  
//
//  Created by Ben Schultz on 2023-11-05.
//

import Foundation
import Publish

extension Theme where Site == Theskinny {
    static var tsobTheme: Theme {
        Theme(htmlFactory: TsobHTMLFactory(), resourcePaths: ["Resources/style/style.css"])
    }
}

