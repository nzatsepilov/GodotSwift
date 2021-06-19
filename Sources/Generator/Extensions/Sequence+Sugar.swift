//
//  Sequence+Sugar.swift
//

import Foundation

extension Sequence where Element: Hashable {

    func hasDuplicates() -> Bool {
        var uniqueElements = Set<Int>()
        return contains { element in
            !uniqueElements.insert(element.hashValue).inserted
        }
    }
}
