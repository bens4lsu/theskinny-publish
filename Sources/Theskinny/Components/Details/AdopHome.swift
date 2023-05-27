//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/27/23.
//

import Foundation
import Publish
import Plot

struct AdopHome: Component {
    
    var context: PublishingContext<Theskinny>
    
    init(_ context: PublishingContext<Theskinny>) {
        self.context = context
    }
        
    var body: Component {
        Article {
            Div {
                AdopHomeV(context)
                AdopHomeK(context)
                Div {
                    Text("If you've found this page because you have your own young Russian or are in the process, you will be interested in ")
                    Link("the process for getting an updated passport once their initial one expires.", url:"/a/adopNewPassport")
                }.class("div-adop-bottomstuff")
            }.class("div-adop-wrapper-inner")
        }
    }
}
