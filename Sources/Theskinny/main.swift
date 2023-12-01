import Foundation
import Publish
import Plot
import Files



//
//
//shell ("rm Resources/img")



do {
    try hideResourceImages()
    
    try Theskinny().publish(withTheme: .tsobTheme, additionalSteps: [
        .writePostPages(),
        .writeRedirectsFromWordpressUrls(),
        .writeVideoAlbumPages(),
        .imageGalleries()
    ])
    
    try restoreSymlinks()
    
    
} catch (let e) {
    print ("Error thrown during site generation:  \(e)")
}



fileprivate func hideResourceImages() throws {
    let root = try Folder(path: ".")
    shell ("rm -r tmp")
    let tmpFolder = try root.createSubfolderIfNeeded(at: "tmp")
    let galleryFolder = try Folder(path: "Resources/img/gal")
    for f in galleryFolder.subfolders {
        let tmpGalFolder = try tmpFolder.createSubfolder(at: f.name)
        let file = try File(path: "\(f.path)pic-desc.txt")
        try file.copy(to: tmpGalFolder)
        let file2  = try File(path: "\(f.path)gal-desc.txt")
        try file2.copy(to: tmpGalFolder)
    }
    shell ("rm Resources/img")
    shell ("mkdir Resources/img")
    shell ("mkdir Resources/img/gal")
    shell ("mv tmp/* Resources/img/gal")
    
}

fileprivate func restoreSymlinks() throws {
    shell ("rm Resources/img")
    shell ("rm Output/img")
    shell ("ln -s /Users/ben/Library/CloudStorage/OneDrive-kidderschultz.com/webdev/sites/theskinny-media/img Resources/img")
    shell ("ln -s /Users/ben/Library/CloudStorage/OneDrive-kidderschultz.com/webdev/sites/theskinny-media/img Output/img")
}


fileprivate func shell(_ command: String) {
    let task = Process()
    let pipe = Pipe()

    task.standardOutput = pipe
    task.standardError = pipe
    task.arguments = ["-c", command]
    task.launchPath = "/bin/zsh"
    task.standardInput = nil
    task.launch()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!

    print(output)
}
