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
    var yearlyCounts = [String: Int]()
    let data = try Data(contentsOf: url)
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .custom(decodeStrategyForDates)
    let result = try decoder.decode([RootObj].self, from: data)
    let mappedResult = result.map { $0.tweet }
    let filteredResult = mappedResult.filter { $0.in_reply_to_status_id_str == nil }
    let sortedResult = filteredResult.sorted { $0.created_at < $1.created_at }

    print ("post count:  \(sortedResult.count)")
    let mpfm = MicroPostFileManager()
    var output = ""
    for post in sortedResult {
        if yearlyCounts[post.year] == nil {
            yearlyCounts[post.year] = 1
        }
        else {
            yearlyCounts[post.year]! += 1
        }
        output += try await mpfm.getYaml(post) + "\n\n"
    }
    print(yearlyCounts)
    try output.write(toFile: mpfm.yamlFile, atomically: true, encoding: .utf8)

} catch(let e) {
    print(e)
}

