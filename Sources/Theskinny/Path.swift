//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/26/23.
//

import Foundation
import Publish

extension Path {
    
    func parent() -> String {
        guard let url = URL(string: self.string) else { return "nil" }
        return url.deletingLastPathComponent().absoluteString
    }
}
