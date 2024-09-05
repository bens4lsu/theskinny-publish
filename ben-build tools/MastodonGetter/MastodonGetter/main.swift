//
//  main.swift
//  MastodonGetter
//
//  Created by Ben Schultz on 2023-09-08.
//

import Foundation

func getPosts() async throws -> (Data, URLResponse)? {
    let session = URLSession.shared
    guard let url = URL(string: "https://mastodon.social/api/v1/accounts/110683690715876419/statuses?limit=20000") else {
        return nil
    }
    return try await session.data(from: url)
}

if let (data, _) = try await getPosts() {
    let decoder = JSONDecoder()
    let mastodonResponse = try decoder.decode([MastodonResponse].self, from: data)
    let mpfm = MicroPostFileManager()
    var output = ""
    for post in mastodonResponse {
        if post.createdAt.year < Date().year {
            output += try await mpfm.getYaml(post) + "\n\n"
        }
    }
    try output.write(toFile: mpfm.yamlFile, atomically: true, encoding: .utf8)
}

