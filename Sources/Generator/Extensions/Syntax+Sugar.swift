import SwiftSyntax
import Foundation

extension Syntax {

    func write(toFileAt url: URL) throws {
        var text = ""
        write(to: &text)
        let data = text.data(using: .utf8)!
        try data.write(to: url)
    }
}
