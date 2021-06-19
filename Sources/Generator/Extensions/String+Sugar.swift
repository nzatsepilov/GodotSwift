import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = capitalizingFirstLetter()
    }

    func camelCased() -> String {
        let parts = split(separator: "_")
        let string: String = zip(parts, parts.indices).lazy
            .map { part, index -> String in
                let part = String(part)
                return index == 0 ? part : part.capitalizingFirstLetter()
            }
            .joined()
        return hasPrefix("_") ? "_\(string)" : string
    }

    func removingPrefix(_ prefix: String) -> String {
        if hasPrefix(prefix) {
            return String(dropFirst(prefix.count))
        }
        return self
    }

    func removingSuffix(_ suffix: String) -> String {
        if hasSuffix(suffix) {
            return String(dropLast(suffix.count))
        }
        return self
    }
}
