//
//  Item.swift
//

import Foundation
import OrderedCollections

struct APIItem: Decodable {
    typealias Constants = [String: Int]

    private enum CodingKeys: String, CodingKey {
        case name
        case baseClassName = "base_class"
        case apiType = "api_type"
        case isSingleton = "singleton"
        case singletonName = "singleton_name"
        case isInstanciable = "instanciable"
        case isReference = "is_reference"
        case constants
        case properties
        case signals
        case methods
        case enums
    }

    enum APIType: String, Decodable {
        case core
        case tools
    }

    struct Property: Decodable {
        enum CodingKeys: String, CodingKey {
            case name
            case type
            case getter
            case setter
            case index
        }

        let name: String
        let type: String
        let getter: String
        let setter: String?
        let index: Int

        var hasSetter: Bool {
            setter != nil
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            name = try container.decode(.name)
            type = try container.decode(.type)
            getter = try container.decode(.getter)

            let setter: String = try container.decode(.setter)
            if !setter.isEmpty {
                self.setter = setter
            } else {
                self.setter = nil
            }

            index = try container.decode(.index)
        }
    }

    struct Argument: Decodable, Hashable {
        private enum CodingKeys: String, CodingKey {
            case name
            case type
            case hasDefaultValue = "has_default_value"
            case defaultValue = "default_value"
        }

        let name: String
        let type: String
        let hasDefaultValue: Bool
        let defaultValue: String
    }

    struct Signal: Decodable {
        let name: String
        let arguments: [Argument]
    }

    struct Method: Decodable, Hashable {
        private enum CodingKeys: String, CodingKey {
            case name
            case returnType = "return_type"
            case isEditor = "is_editor"
            case isNoscript = "is_noscript"
            case isConst = "is_const"
            case isReverse = "is_reverse"
            case isVirtual = "is_virtual"
            case hasVarargs = "has_varargs"
            case isFromScript = "is_from_script"
            case arguments
        }

        let name: String
        let returnType: String
        let isEditor: Bool
        let isNoscript: Bool
        let isConst: Bool
        let isReverse: Bool
        let isVirtual: Bool
        let hasVarargs: Bool
        let isFromScript: Bool
        let arguments: [Argument]
    }

    struct Enum: Decodable {
        typealias Values = [String: Int]
        let name: String
        let values: Values

        var sortedValues: OrderedDictionary<String, Int> {
            ConstantsTransformer.transform(values)
        }
    }

    let name: String
    let baseClassName: String?
    let apiType: APIType
    let isSingleton: Bool
    let singletonName: String?
    let isInstanciable: Bool
    let isReference: Bool
    let constants: Constants
    let properties: [Property]
    let signals: [Signal]
    let methods: OrderedSet<Method>
    let enums: [Enum]

    var sortedConstants: OrderedDictionary<String, Int> {
        ConstantsTransformer.transform(constants)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(.name)

        if let baseClassName: String = try container.decodeIfPresent(.baseClassName), !baseClassName.isEmpty {
            self.baseClassName = baseClassName
        } else {
            baseClassName = nil
        }

        apiType = try container.decode(.apiType)

        isSingleton = try container.decode(.isSingleton)
        if isSingleton {
            singletonName = try container.decode(.singletonName)
        } else {
            singletonName = nil
        }

        isInstanciable = try container.decode(.isInstanciable)
        isReference = try container.decode(.isReference)
        constants = try container.decode(.constants)
        properties = try container.decode(.properties)
        signals = try container.decode(.signals)
        methods = try container.decode(.methods)
        enums = try container.decode(.enums)
    }
}
