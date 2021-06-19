//
//  EnumDecl+Sugar.swift
//

import SwiftSyntax
import SwiftSyntaxBuilder
import OrderedCollections

extension EnumDecl {

    private enum Members {
        case cases(OrderedDictionary<String, Int>)
        case staticVariables(OrderedDictionary<String, Int>)
    }

    init(`enum`: APIItem.Enum) {
        let name = NameTransformer.transformTypeName(`enum`.name)
        self.init(name: name, items: `enum`.sortedValues)
    }

    init(name: String, items: OrderedDictionary<String, Int>) {
        if items.values.hasDuplicates() {
            self.init(name: name, members: .staticVariables(items))
        } else {
            self.init(name: name, members: .cases(items))
        }
    }

    private init(name: String, members: Members) {
        let items: [MemberDeclListItem]
        let inheritanceClause: TypeInheritanceClause?
        switch members {
        case .cases(let cases):
            items = Self.makeCases(from: cases)
            inheritanceClause = TypeInheritanceClause(typeName: "Int")
        case .staticVariables(let variables):
            items = Self.makeStaticVariables(from: variables)
            inheritanceClause = nil
        }

        self.init(
            attributes: AttributeList([DeclModifier.public]),
            modifiers: nil,
            enumKeyword: Tokens.enum,
            identifier: SyntaxFactory.makeIdentifier(name).withTrailingTrivia(.spaces(1)),
            genericParameters: nil,
            inheritanceClause: inheritanceClause,
            genericWhereClause: nil,
            members: MemberDeclBlock(
                leftBrace: Tokens.leftBrace,
                members: MemberDeclList(items),
                rightBrace: Tokens.rightBrace
            )
        )
    }

    private static func makeCases(from constants: OrderedDictionary<String, Int>) -> [MemberDeclListItem] {
        constants.map { constant in
            let element = EnumCaseElement(
                identifier: SyntaxFactory.makeIdentifier(constant.key),
                associatedValue: nil,
                rawValue: InitializerClause(
                    equal: Tokens.equal,
                    value: IntegerLiteralExpr(
                        digits: SyntaxFactory.makeIntegerLiteral("\(constant.value)")
                    )
                ),
                trailingComma: nil
            )
            return MemberDeclListItem(
                decl: EnumCaseDecl(
                    attributes: nil,
                    modifiers: nil,
                    caseKeyword: Tokens.case,
                    elements: EnumCaseElementList([element])
                ),
                semicolon: nil
            )
        }
    }

    private static func makeStaticVariables(from constants: OrderedDictionary<String, Int>) -> [MemberDeclListItem] {
        constants.map { constant in
            let variable = VariableDecl(
                attributes: nil,
                modifiers: ModifierList([.public, .static]),
                letOrVarKeyword: Tokens.let,
                bindings: PatternBindingList([
                    PatternBinding(
                        pattern: IdentifierPattern(identifier: Tokens.identifier(constant.key)),
                        typeAnnotation: nil,
                        initializer: InitializerClause(
                            equal: Tokens.equal,
                            value: IntegerLiteralExpr(
                                digits: Tokens.integerLiteral("\(constant.value)")
                            )
                        ),
                        accessor: nil,
                        trailingComma: nil
                    )
                ])
            )
            return MemberDeclListItem(
                decl: variable,
                semicolon: nil
            )
        }
    }
}
