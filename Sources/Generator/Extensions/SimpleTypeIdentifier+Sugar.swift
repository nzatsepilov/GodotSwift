//
//  SimpleTypeIdentifier+Sugar.swift
//  

import SwiftSyntax
import SwiftSyntaxBuilder

extension SimpleTypeIdentifier {

    init(typeName: String, trailingTrivia: Trivia = []) {
        let identifier = Tokens.identifier(typeName).withTrailingTrivia(trailingTrivia)
        self.init(name: identifier, genericArgumentClause: nil)
    }
}
