//
//  MastodonResponse.swift
//  MastodonGetter
//
//  Created by Ben Schultz on 2023-09-10.
//

import Foundation

enum MastodonResponseDecodeError: String, Error {
    case mediaIdNotUInt = "MastodonMedia id field is not convertable to UInt"
    case responseIdNotUInt = "MastodonResponse id field is not convertable to UInt"
    case createdAtNotDate = "MastodonResponse created_at value is not convertable to Date"
}

struct MastodonMedia: Decodable {
    let id: UInt
    let url: String
    let previewUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case previewUrl = "preview_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let id = container.decodeAndConvertToUInt(forKey: .id) else {
            throw MastodonResponseDecodeError.mediaIdNotUInt
        }
        self.id = id
        self.url = try container.decode(String.self, forKey: .url)
        self.previewUrl = try container.decode(String.self, forKey: .previewUrl)
    }
}


struct MastodonResponse: Decodable {
    
    let id: UInt
    let createdAt: Date
    let inReplyToId: UInt?
    let content: String
    let mediaAttachments: [MastodonMedia]
    let uri: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case inReplyToId = "in_reply_to_id"
        case content
        case mediaAttachments = "media_attachments"
        case uri
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        guard let id = container.decodeAndConvertToUInt(forKey: .id) else {
            throw MastodonResponseDecodeError.responseIdNotUInt
        }
        
        guard let date = container.decodeAndConvertToDate(forKey: .createdAt) else {
            throw MastodonResponseDecodeError.createdAtNotDate
        }
        
        self.id = id
        self.createdAt = date
        self.inReplyToId = container.decodeAndConvertToUInt(forKey: .inReplyToId)
        self.content = try container.decode(String.self, forKey: .content)
        self.mediaAttachments = try container.decode([MastodonMedia].self, forKey: .mediaAttachments)
        self.uri = try container.decode(String.self, forKey: .uri)
    }
    
}

extension KeyedDecodingContainer {
    func decodeAndConvertToUInt(forKey key: KeyedDecodingContainer<K>.Key) -> UInt? {
        guard let val = try? self.decode(String.self, forKey: key) else {
            return nil
        }
        return UInt(val)
    }
    
    func decodeAndConvertToDate(forKey key: KeyedDecodingContainer<K>.Key) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let val = try? self.decode(String.self, forKey: key) else {
            return nil
        }
        return formatter.date(from: val)
    }
}
