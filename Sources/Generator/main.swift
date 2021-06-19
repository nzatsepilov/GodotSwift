import Foundation
import SwiftSyntaxBuilder
import SwiftSyntax
import OrderedCollections

private extension SyntaxBuildable {

    func writeSyntax(toFileAt url: URL, using format: Format = .init(indentWidth: 4)) throws {
        try buildSyntax(format: format).write(toFileAt: url)
    }
}

let args = Array(CommandLine.arguments.dropFirst())

if args.count < 2 {
    print("Please specify following paths:")
    print("<path to api.json> <path where generate swift files>")
}

let apiURL = URL(fileURLWithPath: args[0])
let directoryURL = URL(fileURLWithPath: args[1], isDirectory: true)

print("Reading api.json at `\(apiURL.path)`")
let api = try API(url: apiURL)

let fileManager = FileManager.default
try fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)

print("Generating swift files at `\(directoryURL.path)`")
let generator = APIFilesGenerator(api: api)
try generator.generateFiles(at: directoryURL)
