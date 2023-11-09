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

//try VelvetElvisBigTrip().publish(withTheme: veTheeme, indentation: <#T##Indentation.Kind?#>, at: <#T##Path?#>, rssFeedSections: <#T##Set<SectionID>#>, rssFeedConfig: <#T##RSSFeedConfiguration?#>, deployedUsing: <#T##DeploymentMethod<Self>?#>, additionalSteps: <#T##[PublishingStep<Self>]#>, plugins: <#T##[Plugin<Self>]#>, file: <#T##StaticString#>)
