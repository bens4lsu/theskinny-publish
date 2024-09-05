//
//  File.swift
//  
//
//  Created by Ben Schultz on 2024-09-04.
//

import Foundation
import Files
import Plot
import Yams

struct MicroPostData {
    static let microPosts: [MicroPost] = {
        
        let paths =  ["./Content-custom/mastodon-posts.yaml",
                      "./Content-custom/twitter-posts.yaml"
        ]
        
        let decoder = YAMLDecoder()
        var decoded = [MicroPost]()
        do {
            for path in paths {
                let file = try File(path: path)
                let fileYaml = try file.readAsString()
                decoded += try decoder.decode([MicroPost].self, from: fileYaml)
            }
        } catch(let e) {
            print ("Yaml file decode error on:  \(e)")
        }
        return decoded
    }()
    
    static let years: Set<String> = {
        return Set(microPosts.map {
            EnvironmentKey.formatterYYYY.string(from: $0.date)
        })
    }()
    
    static let postsByYear: [String: [MicroPost]] = {
        var result = [String: [MicroPost]]()
        for year in years {
            result[year] = microPosts.filter {
                EnvironmentKey.formatterYYYY.string(from: $0.date) == year
            }
        }
        return result
    }()
    
}
