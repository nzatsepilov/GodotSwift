//
//  ClassDecl+Sugar.swift
//  

import SwiftSyntax
import SwiftSyntaxBuilder

extension ClassDecl {

    init(name: String, baseClassName: String? = nil, members: [MemberDeclListItem]) {
        var typeInheritanceClause: TypeInheritanceClause?
        if let baseClassName = baseClassName {
            typeInheritanceClause = TypeInheritanceClause(typeName: baseClassName)
        }

        let space = Trivia.spaces(1)
        self.init(
            attributes: nil,
            modifiers: ModifierList([.public]),
            classOrActorKeyword: Tokens.class.withTrailingTrivia(space),
            identifier: Tokens.identifier(name).withTrailingTrivia(space),
            genericParameterClause: nil,
            inheritanceClause: typeInheritanceClause,
            genericWhereClause: nil,
            members: MemberDeclBlock(
                leftBrace: SyntaxFactory.makeLeftBraceToken(),
                members: MemberDeclList(members),
                rightBrace: SyntaxFactory.makeRightBraceToken()
            )
        )
    }
}
