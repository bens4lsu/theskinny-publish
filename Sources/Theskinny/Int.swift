//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/15/23.
//

import Foundation

extension Int {
    var isEven: Bool {
        self % 2 == 0
    }
    
    var isOdd: Bool {
        !self.isEven
    }
}

extension UInt8 {
    func zeroPadded(_ numDigitsUInt: UInt16) -> String {
        let numDigits = Int(numDigitsUInt)
        return String (
            (String(repeating: "0", count: numDigits) + String(self))
                .suffix(numDigits)
        )
    }
}
