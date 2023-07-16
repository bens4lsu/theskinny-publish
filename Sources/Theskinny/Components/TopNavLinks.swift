//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/19/23.
//

import Foundation
import Plot
import Publish


class LinkInfo: Decodable {
    let text: String
    let url: String
    
    init(text: String?, url: String) {
        self.text = text ?? "---"
        self.url = url
    }
    
    convenience init(_ text: String?, _ url: String) {
        self.init(text: text, url: url)
    }
}



class TopNavLinks: Component {
    
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
}
    
fileprivate class ArrowToLeft: LinkInfo, Component {
    var body: Component {
        Div {
            Div("«").class("div-left-ticks")
            Link("\(self.text)", url: self.url).class("div-left-text")
        }.class("link-arrow link-arrow-left")
    }
}
    
fileprivate class MiddleLink: LinkInfo, Component {
    var body: Component {
        Div {
            Link("\(self.text)", url: self.url)
        }.class("link-arrow link-middle")
    }
}
    
fileprivate class ArrowToRight: LinkInfo, Component {
    var body: Component {
        Div {
            Link("\(self.text)", url: self.url).class("div-right-text")
            Div("»").class("div-right-ticks")
        }.class("link-arrow link-arrow-right")
    }
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

