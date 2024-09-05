////
////  File.swift
////  
////
////  Created by Ben Schultz on 5/25/23.
////
//
//import Foundation
//import Publish
//import Plot
//
//struct HomeTweets: Component {
//    
//    var embedCode = """
//        <a class="twitter-timeline"  href="https://twitter.com/bens4lsu"  data-widget-id="365188339789340672" data-chrome="nofooter transparent" data-border-color="#000000">Tweets by @bens4lsu</a>
//        <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
//    """
//    
//    var body: Component {
//        Div {
//            Markdown(embedCode)
//        }.class("div-home-tweets")
//    }
//}
