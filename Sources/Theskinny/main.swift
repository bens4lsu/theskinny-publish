import Foundation
import Publish
import Plot
import Files

// This type acts as the configuration for your website.
struct Theskinny: Website {
    enum SectionID: String, WebsiteSectionID, CaseIterable {
        case home
        case blog2
        case haikus
        case njdispatches
        case adopv
        case adopk
        case vid
    }

    struct ItemMetadata: WebsiteItemMetadata {
        var id: Int?
        var description: String?
        var adopSection: String?
        var videoAlbums: [Int]?
    }

    var url = URL(string: "https://theskinnyonbenny.com")!
    var name = "theskinnyonbenny.com"
    var description = "Personal Website, Ben Schultz, Baton Rouge"
    var language: Language { .english }
    var imagePath: Path? { "img" }

    

}

extension Theme where Site == Theskinny {
    static var tsobTheme: Theme {
        Theme(htmlFactory: TsobHTMLFactory(), resourcePaths: ["Resources/style/style.css"])
    }
}

// This will generate the website
try Theskinny().publish(withTheme: .tsobTheme, additionalSteps: [
    .writePostPages(),
    .writeRedirectsFromWordpressUrls(),
    .writeVideoAlbumPages(),
])


// TODO: blog editing

//  http://localhost:8000/blog2/thinking-football/ -- Is this link alive?  https://youtu.be/NqOENqJj4lk
//  http://localhost:8000/blog2/shipping-news/   http://www.photographers1.com/Sailing/NauticalTerms&Nomenclature.html
//  http://localhost:8000/blog2/rolling-rolling-rolling-through-the-summer/   check images
//  http://localhost:8000/blog2/thoughts-about-3-songs-from-the-80s/  need to add apple music playlist
