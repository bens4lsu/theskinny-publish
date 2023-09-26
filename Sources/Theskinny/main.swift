import Foundation
import Publish
import Plot
import Files


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
        var ogImg: String?
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


