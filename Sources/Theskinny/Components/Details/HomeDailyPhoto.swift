//
//  File.swift
//  
//
//  Created by Ben Schultz on 5/25/23.
//

import Foundation
import Publish
import Plot

struct HomeDailyPhoto: Component {
    
    var body: Component {
        Div {
            H1("The Daily Photo")
            Image("/dailyphotostore/2005/20051001.jpg").id("homeDPImage")
            Div {
                Text("Have you seen them all?  Check the ")
                Link("daily photo page", url: "/dailyphoto")
                Text(" to be sure.")
            }.class("div-dp-message")
        }.class("div-home-dailyphoto")
    }
}
