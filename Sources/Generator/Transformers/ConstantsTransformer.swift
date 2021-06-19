//
//  ConstantsTransformer.swift
//  

import OrderedCollections

enum ConstantsTransformer {

    static func transform(_ constants: [String: Int]) -> OrderedDictionary<String, Int> {
        var result = OrderedDictionary<String, Int>()
        result.reserveCapacity(constants.count)
        return constants.lazy
            .sorted { lhs, rhs in
                if lhs.key.commonPrefix(with: rhs.key).isEmpty {
                    return lhs.key < rhs.key
                }
                return lhs.value < rhs.value
            }
            .reduce(into: result) { result, constant in
                let name = NameTransformer.transformConstantName(constant.key)
                result[name] = constant.value
            }
    }
}
