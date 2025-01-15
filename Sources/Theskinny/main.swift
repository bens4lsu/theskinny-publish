import Foundation
import Publish
import Plot
import Files


fileprivate var mediaPath: String { "/Volumes/BenPortData/theskinny-media" }


do {
    shell("chflags -R uchg \(mediaPath)")
    shell("chmod -R 777 ./tmp")
    shell("chflags nohidden Output")
    
    defer {
        try? restoreSymlinks()
        shell("chflags -R nouchg \(mediaPath)")
        shell("chflags hidden Output")
    }
    
    /*
     
    command to unlock folders recursive:
     
    chflags -R nouchg /Volumes/BenPortData/theskinny-media/img/gal
     
    */
    
    
    try hideResourceImages()
        
    try Theskinny().publish(withTheme: .tsobTheme, additionalSteps: [
        .printDate(),
        .writePostPages(),
        .writeRedirectsFromWordpressUrls(),
        .writeVideoAlbumPages(),
        .imageGalleries(),
        .dailyPhotos(),
        .oldMicroPosts(),
        .playlists(),
        .printDate()
    ])
    shell("say \"Ding.\"")
    print (Date())
    
    
} catch (let e) {
    print ("Error thrown during site generation:  \(e)")
}


fileprivate func hideResourceImages() throws {
    let root = try Folder(path: ".")
    try root.subfolder(at: "tmp").delete()
    shell ("rm Output/img && rm Output/sound && rm Output/dailyphotostore")
    let tmpFolder = try root.createSubfolderIfNeeded(at: "tmp")
    let galleryFolder = try Folder(path: "\(mediaPath)/img/gal")
    for f in galleryFolder.subfolders {
        let tmpGalFolder = try tmpFolder.createSubfolder(at: f.name)
        let file = try File(path: "\(f.path)pic-desc.txt")
        try file.copy(to: tmpGalFolder)
        let file2  = try File(path: "\(f.path)gal-desc.txt")
        try file2.copy(to: tmpGalFolder)
    }
    shell ("rm Resources/img")
    shell ("rm Resources/sound")
    shell ("rm Resources/dailyphotostore")
    shell ("mkdir Resources/img")
    shell ("mkdir Resources/img/gal")
    shell ("mv tmp/* Resources/img/gal")
}

fileprivate func restoreSymlinks() throws {
    shell ("chflags -R nouchg Resources/img")
    shell ("chflags -R nouchg Output/img")
    shell ("rm -r Resources/img")
    shell ("rm -r Output/img")
    shell ("cd Resources && ln -s \(mediaPath)/img img")
    shell ("cd Output && ln -s \(mediaPath)/img img")
    shell ("cd Output && ln -s \(mediaPath)/dailyphotostore dailyphotostore")
    shell ("cd Resources && ln -s \(mediaPath)/sound sound")
    shell ("cd Output && ln -s \(mediaPath)/sound sound")
    shell ("cd Resources && ln -s \(mediaPath)/dailyphotostore dailyphotostore")

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



