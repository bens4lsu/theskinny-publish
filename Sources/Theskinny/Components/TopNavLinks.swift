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
    var middleLinkInfo: LinkInfo?
    var rightLinkInfo: LinkInfo?
    
    init(_ leftLinkInfo: LinkInfo?, _ middleLinkInfo: LinkInfo?, _ rightLinkInfo: LinkInfo?) {
        self.leftLinkInfo = leftLinkInfo
        self.middleLinkInfo = middleLinkInfo
        self.rightLinkInfo = rightLinkInfo
    }
    
    init(leftLinkInfo: LinkInfo? = nil, rightLinkInfo: LinkInfo? = nil) {
        self.leftLinkInfo = leftLinkInfo
        self.rightLinkInfo = rightLinkInfo
    }
    
    var body: Component {
        let leftside: Component = leftLinkInfo == nil ? EmptyToLeft() : ArrowToLeft(leftLinkInfo!.text, leftLinkInfo!.url)
        let middle: Component = middleLinkInfo == nil ? EmptyMiddle() : MiddleLink(middleLinkInfo!.text, middleLinkInfo!.url)
        let rightside: Component = rightLinkInfo == nil ? EmptyToRight() : ArrowToRight(rightLinkInfo!.text, rightLinkInfo!.url)
        
        return Div {
            leftside
            middle
            rightside
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
                Div("«").class("div-left-ticks")
                Link("\(text)", url: url).class("div-left-text")
            }.class("link-arrow link-arrow-left")
        }
    }
    
    fileprivate struct MiddleLink: Component {
        var text: String
        var url: String
        
        init(_ text: String, _ url: String) {
            self.text = text
            self.url = url
        }
        
        var body: Component {
            Div {
                Link("\(text)", url: url)
            }.class("link-arrow link-middle")
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
                Link("\(text)", url: url).class("div-right-text")
                Div("»").class("div-right-ticks")
            }.class("link-arrow link-arrow-right")
        }
        
//        var empty: Component {
//            Div { Text("&nbsp;") }.class("link-arrow-right")
//        }
    }
    
    fileprivate struct EmptyToLeft: Component {
        var body: Component {
            Div {  }.class("link-arrow link-arrow-left")
        }
    }
    
    fileprivate struct EmptyToRight: Component {
        var body: Component {
            Div {  }.class("link-arrow link-arrow-right")
        }
    }
    
    fileprivate struct EmptyMiddle: Component {
        var body: Component {
            Div {  }.class("link-arrow link-middle")
        }
    }
}
