import Foundation

extension FileManager {

    var currentDirectoryURL: URL {
        URL(fileURLWithPath: currentDirectoryPath)
    }
}
