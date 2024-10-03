//
//  File.swift
//  
//
//  Created by Ben Schultz on 6/5/23.
//

import Foundation
import Plot
import Publish


public struct Script: Component {
    
    public var body: Component { node }
    private var node: Node<HTML.ScriptContext>
        
        
    public init(_ string: String) {
        let node: Node<HTML.ScriptContext> = .script(.text(string))
        self.init(node: node)
    }
    
    private init(node: Node<HTML.ScriptContext>) {
        self.node = node
    }
}

extension HTML.ScriptContext: @retroactive HTMLScriptableContext { }
