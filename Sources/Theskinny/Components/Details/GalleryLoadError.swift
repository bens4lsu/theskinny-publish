//
//  File.swift
//  
//
//  Created by Ben Schultz on 2024-01-29.
//

import Foundation

enum GalleryLoadError: Error {
    case noSpaceInDirectoryName
    case nonIntegerFirstPartOfDirectoryName
    case errorReadingCaptionFile
    case attemptToLoadGalleryWithInvalidID
}
