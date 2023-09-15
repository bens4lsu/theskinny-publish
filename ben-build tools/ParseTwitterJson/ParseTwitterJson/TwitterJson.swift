//
//  TwitterJson.swift
//  ParseTwitterJson
//
//  Created by Ben Schultz on 2023-09-15.
//

import Foundation

struct RealRoot: Codable {
    var rootObj: RootObj
    
    init(from decoder : Decoder) throws {
        //unkeyed because we are getting an array as container
        var unkeyedContainer = try decoder.unkeyedContainer()
        let decoded = try unkeyedContainer.decode(RealRoot.self)
        self.rootObj = decoded.rootObj
    }
}

struct RootObj: Codable {
    var tweet: Tweet
}

struct Tweet: Codable {
    struct Url: Codable {
        var expanded_url: String
    }
    
    var retweeted: Bool?
    var urls: [Url]?
    var id: String
    var created_at: Date
    var full_text: String
    var in_reply_to_status_id_str: String?
    var media_url: String?
    
}


