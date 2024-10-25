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
    
    private var string: String
    
    public var body: Component {
        let node: Node<HTML.ScriptContext> = .script(.text(string))
        return node
    }
    
    public var headerNode: Node<HTML.HeadContext> {
        let node = Node.raw(string) as Node<HTML.HeadContext>
        return .element(named: "script", nodes: [node])
    }
        
    public init(_ string: String) {
        self.string = string
    }

}

extension HTML.ScriptContext: @retroactive HTMLScriptableContext { }
