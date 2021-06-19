//
//  DeclModifier+Sugar.swift
//  

import SwiftSyntax
import SwiftSyntaxBuilder

extension DeclModifier {

    static var `public`: DeclModifier {
        DeclModifier(
            name: Tokens.public,
            detailLeftParen: nil,
            detail: nil,
            detailRightParen: nil
        )
    }

    static var `override`: DeclModifier {
        DeclModifier(
            name: Tokens.identifier("override").withTrailingTrivia(.spaces(1)),
            detailLeftParen: nil,
            detail: nil,
            detailRightParen: nil
        )
    }

    static var `static`: DeclModifier {
        DeclModifier(
            name: Tokens.static,
            detailLeftParen: nil,
            detail: nil,
            detailRightParen: nil
        )
    }
}
