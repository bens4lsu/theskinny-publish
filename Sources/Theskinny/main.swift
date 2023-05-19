import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct Theskinny: Website {
    enum SectionID: String, WebsiteSectionID, CaseIterable {
        case home
        case blog2
        case haikus
//        case pages
//        case photoGalleries
//        case dailyPhotos
//        case videos
//        case adopt
//        case extras
//        case others
    }

    struct ItemMetadata: WebsiteItemMetadata {
        var id: Int
    }

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

// This will generate the website
try Theskinny().publish(withTheme: .tsobTheme)


