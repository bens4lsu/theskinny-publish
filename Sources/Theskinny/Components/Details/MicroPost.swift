//
//  File.swift
//  
//
//  Created by Ben Schultz on 2023-09-14.
//

import Foundation
import Plot
import Publish

struct MicroPost: Component, Decodable {
    
    enum PostSource: String, Decodable {
        case mastodon
        case twitter
        
        var platoformImage: String {
            switch self {
            case .mastodon:
                return "/img/micro/mastodon-logo.png"
            case .twitter:
                return "/img/micro/twitter-bird.png"
            }
        }
    }
    
    var date: Date
    var source: PostSource
    var sourceUrl: String
    var content: String
    var media: String?
    
    var dateString: String {
        date.formatted(date: .abbreviated, time: .shortened)
    }
    
    
    var body: Plot.Component {
        Div {
            Div {
                Div {
                    Image("/img/micro/bennyst.png")
                }.class("micro-post-icon-top")
                Div {
                    Image(source.platoformImage)
                }.class("micro-post-icon-bottom")
            }.class("micro-post-icons")
            Div {
                Div(Markdown(content)).class("micro-post-content")
                Div(Markdown(media ?? "")).class("micro-post-media")
                Div {
                    Link(dateString, url: sourceUrl).linkTarget(.blank)
                }
            }
        }.class("micro-post-container")
    }
}

struct MicroPosts: Component {
    let mposts: [MicroPost]
    let allYears: Set<String>?
    
    let formatterYYYY: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    var years: Set<String> {
        return Set(mposts.map {
            formatterYYYY.string(from: $0.date)
        })
    }
    
    var postsByYear: [String: [MicroPost]] {
        var result = [String: [MicroPost]]()
        for year in years {
            result[year] = mposts.filter {
                formatterYYYY.string(from: $0.date) == year
            }
        }
        return result
    }
    
    var latestYear: String? {
        years.sorted().last
    }

    var body: Plot.Component {
        guard let latestYear = self.latestYear else {
            return EmptyComponent()
        }
        
        return Article {
            H4("Previous Years")
            previousYearLinks()
            H2("\(latestYear) Micro Posts from Social Media")
            List(postsByYear[latestYear]!) { post in
                post
            }.listStyle(.listAsDivs)
        }
    }
    
    func forYear(year: String) -> Component {
        if let posts = postsByYear[year] {
            return MicroPosts(mposts: posts, allYears: years)
        }
        return EmptyComponent()
    }
    
    func previousYearLinks() -> Component {
        var years = allYears ?? years
        if let latestYear {
            years.remove(latestYear)
        }
        return List(years.sorted()) { year in
            Link(year, url: "/micro-posts/\(year)")
        }.listStyle(.inlineListOfLinks)
    }
}

