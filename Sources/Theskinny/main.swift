import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct Theskinny: Website {
    enum SectionID: String, WebsiteSectionID, CaseIterable {
        case posts
        case home
        case about
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://theskinnyonbenny.com")!
    var name = "The Skinny On Benny"
    var description = "Personal Website, Ben Schultz, Baton Rouge"
    var language: Language { .english }
    var imagePath: Path? { "img" }
}

extension Theme where Site == Theskinny {
    static var tsobTheme: Theme {
        Theme(htmlFactory: TsobHTMLFactory(), resourcePaths: ["Resources/TsobTheme/style.css"])
    }
}

// This will generate your website using the built-in Foundation theme:
try Theskinny().publish(withTheme: .tsobTheme)


