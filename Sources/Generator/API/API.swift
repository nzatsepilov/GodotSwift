//
//  API.swift
//

import Foundation
import OrderedCollections

final class API {

    let items: [APIItem]

    private let itemsMap: [String: APIItem]

    public init(url: URL) throws {
        let data = try Data(contentsOf: url)
        items = try JSONDecoder().decode([APIItem].self, from: data)
        itemsMap = items.reduce(into: [String: APIItem]()) { $0[$1.name] = $1 }
    }

    func dumpTypes() {
        var types = OrderedSet<String>()
        types.reserveCapacity(1000)

        api.items.forEach { item in
            item.methods.forEach { method in
                types.append(method.returnType)
                method.arguments.map(\.type).forEach { type in
                    types.append(type)
                }
            }
        }

        types.forEach { print($0) }
    }

    func isMethodOverriden(_ method: APIItem.Method, in item: APIItem) -> Bool {
        guard let baseClassName = item.baseClassName,
              let parentItem = itemsMap[baseClassName] else {
            return false
        }

        if parentItem.methods.contains(where: { $0.name == method.name }) {
            return true
        }

        return isMethodOverriden(method, in: parentItem)
    }
}
