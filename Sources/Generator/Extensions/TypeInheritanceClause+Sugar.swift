//
//  TypeInheritanceClause+Sugar.swift
//

import SwiftSyntax
import SwiftSyntaxBuilder

extension TypeInheritanceClause {

    init(typeName: String) {
        self.init(
            colon: Tokens.colon,
            inheritedTypeCollection: InheritedTypeList([
                InheritedType(
                    typeName: SimpleTypeIdentifier(typeName: typeName, trailingTrivia: .spaces(1)),
                    trailingComma: nil
                )
            ])
        )
    }
}
