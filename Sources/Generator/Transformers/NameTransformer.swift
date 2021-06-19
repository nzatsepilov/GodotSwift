//
//  NameTransformer.swift
//  

enum NameTransformer {

    // MARK: - Constants

    static func transformConstantName(_ name: String) -> String {
        name.lowercased().camelCased()
    }

    // MARK: - Types

    static func transformTypeName(_ name: String) -> String {
        if name.hasPrefix("enum") {
            return transformEnumTypeName(name)
        }

        if name.hasPrefix("Pool"), name.hasSuffix("Array") {
            return transformPoolTypeName(name)
        }

        return transformSimpleTypeName(name)
    }

    private static func transformSimpleTypeName(_ name: String) -> String {
        switch name {
        case "void":
            return "Void"
        case "bool":
            return "Bool"
        case "int":
            return "Int"
        case "float":
            return "Float"
        case "Byte":
            return "UInt8"
        case "Real":
            return "Float"
        case "Type":
            return "`Type`"
        default:
            return name
        }
    }

    private static func transformEnumTypeName(_ name: String) -> String {
        name.removingPrefix("enum.").replacingOccurrences(of: "::", with: ".")
    }

    private static func transformPoolTypeName(_ name: String) -> String {
        var name = name.removingPrefix("Pool").removingSuffix("Array")
        name = transformTypeName(name)
        return "[\(name)]"
    }

    // MARK: - Functions

    static func transformFunctionName(_ name: String) -> String {
        let name = name.camelCased()

        switch name {
        case "init":
            return "`init`"
        case "import":
            return "`import`"
        default:
            return name
        }
    }

    static func transformArgumentName(_ name: String, argumentTypeName: String) -> String {
        let name = name.camelCased()

        switch (name, argumentTypeName) {
        case ("var", "Variant"):
            return "variant"
        case ("arg0", "InputEvent"):
            return "event"
        default:
            return name
        }
    }
}
