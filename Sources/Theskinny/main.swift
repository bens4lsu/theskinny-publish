import Foundation
import Publish
import Plot
import Files



try Theskinny().publish(withTheme: .tsobTheme, additionalSteps: [
    .writePostPages(),
    .writeRedirectsFromWordpressUrls(),
    .writeVideoAlbumPages(),
    .imageGalleries()
])
