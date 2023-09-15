//
//  main.swift
//  ParseTwitterJson
//
//  Created by Ben Schultz on 2023-09-15.
//

import Foundation

func decodeStrategyForDates (decoder: Decoder) throws -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEE MMM dd hh:mm:ss Z yyyy"
    let dateString = try decoder.singleValueContainer().decode(String.self)
    return dateFormatter.date(from: dateString) ?? Date()
}

let path = "/Users/ben/XCode/projects/Publish Web Sites/theskinny/ben-build tools"
let url = URL(fileURLWithPath: path).appendingPathComponent("tweets.js")

do {
    let data = try Data(contentsOf: url)
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .custom(decodeStrategyForDates)
    let result = try decoder.decode([RootObj].self, from: data)
    let mpfm = MicroPostFileManager()
    var output = ""
    for post in result {
        output += try await mpfm.getYaml(post.tweet) + "\n\n"
    }
    try output.write(toFile: mpfm.yamlFile, atomically: true, encoding: .utf8)

} catch(let e) {
    print(e)
}

