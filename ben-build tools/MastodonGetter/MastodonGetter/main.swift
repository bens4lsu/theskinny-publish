//
//  main.swift
//  MastodonGetter
//
//  Created by Ben Schultz on 2023-09-08.
//

import Foundation

func getPosts() async throws -> (Data, URLResponse)? {
    let session = URLSession.shared
    guard let url = URL(string: "https://mastodon.social/api/v1/accounts/110683690715876419/statuses?limit=20") else {
        return nil
    }
    return try await session.data(from: url)
}

if let (data, _) = try await getPosts() {
    let decoder = JSONDecoder()
    let mastodonResponse = try decoder.decode([MastodonResponse].self, from: data)
    let mpfm = MicroPostFileManager()
    for post in mastodonResponse {
        try await mpfm.write(post)
    }
}

