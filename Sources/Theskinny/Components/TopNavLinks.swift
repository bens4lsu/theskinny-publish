//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/19/23.
//

import Foundation
import Plot
import Publish


struct TopNavLinks: Component {
    
    struct LinkInfo {
        let text: String
        let url: String
        
        init(text: String?, url: String) {
            self.text = text ?? "---"
            self.url = url
        }
    }
    
    var leftLinkInfo: LinkInfo?
    var rightLinkInfo: LinkInfo?
    
    var body: Component {
        Div {
            if leftLinkInfo != nil {
                ArrowToLeft(leftLinkInfo!.text, leftLinkInfo!.url)
            }
            
            if rightLinkInfo != nil {
                ArrowToRight(rightLinkInfo!.text, rightLinkInfo!.url)
            }
        }.class("top-nav-links")
    }
    
    fileprivate struct ArrowToLeft: Component {
        var text: String
        var url: String
        
        init(_ text: String, _ url: String) {
            self.text = text
            self.url = url
        }
        
        var body: Component {
            Div {
                Link("« \(text)", url: url)
            }.class("link-arrow-left")
        }
    }
    
    fileprivate struct ArrowToRight: Component {
        var text: String
        var url: String
        
        init(_ text: String, _ url: String) {
            self.text = text
            self.url = url
        }
        
        var body: Component {
            Div {
                Link("\(text) »", url: url)
            }.class("link-arrow-right")
        }
    }
}
