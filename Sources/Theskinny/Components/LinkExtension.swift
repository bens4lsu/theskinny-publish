//
//  File.swift
//  Theskinny
//
//  Created by Ben Schultz on 2024-10-16.
//

import Foundation
import Plot
import Publish

extension Link {
    func toNewScreen() -> Component {
        let att = Attribute<Any>(
            name: "target",
            value: "_blank",
            replaceExisting: true,
            ignoreIfValueIsEmpty: true
        )
        
        return self.attribute(att)
    }
}
