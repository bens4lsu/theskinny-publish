//
//  File.swift
//  
//
//  Created by Ben Schultz on 7/11/23.
//

import Foundation
extension StringProtocol {
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }
    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        ranges(of: string, options: options).map(\.lowerBound)
    }
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
              let range = self[startIndex...]
            .range(of: string, options: options) {
            result.append(range)
            startIndex = range.lowerBound < range.upperBound ? range.upperBound :
            index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
    
    func substring(from fromPosition: Int, to toPosition: Int) -> String {
        let indexStart = self.index(self.startIndex, offsetBy: fromPosition)
        let indexEnd = self.index(self.startIndex, offsetBy: toPosition)
        let range = indexStart...indexEnd
        let substring = self[range]
        return String(substring)
    }
    
    func dowToNumber() -> Int {
        if self == "Monday" { return 2 }
        else if self == "Tuesday" { return 3 }
        else if self == "Wednesday" { return 4 }
        else if self == "Thursday" { return 5 }
        else if self == "Friday" { return 6 }
        else if self == "Saturday" { return 7 }
        return 1
    }
}


internal extension String {
    func normalized() -> String {
        String(lowercased().compactMap { character in
            if character.isWhitespace || character == "-" {
                return "-"
            }

            if character.isLetter || character.isNumber {
                return character
            }

            return nil
        })
    }
}
