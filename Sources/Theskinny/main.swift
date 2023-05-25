import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct Theskinny: Website {
    enum SectionID: String, WebsiteSectionID, CaseIterable {
        case home
        case blog2
        case haikus
        case njdispatches

    }

    struct ItemMetadata: WebsiteItemMetadata {
        var id: Int
        var description: String?
    }

    var url = URL(string: "https://theskinnyonbenny.com")!
    var name = "theskinnyonbenny.com"
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
try Theskinny().publish(withTheme: .tsobTheme, additionalSteps: [
    // TODO:  folder and files for dead link redirects on blog2
    .writePostPages(),
])


