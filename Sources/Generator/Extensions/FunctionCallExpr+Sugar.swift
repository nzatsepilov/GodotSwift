//
//  FunctionCallExpr+Sugar.swift
//  

import SwiftSyntax
import SwiftSyntaxBuilder

extension FunctionCallExpr {

    static func fatalError(message: String) -> FunctionCallExpr {
        FunctionCallExpr(
            calledExpression: IdentifierExpr(
                identifier: Tokens.identifier("fatalError"),
                declNameArguments: nil
            ),
            leftParen: Tokens.leftParen,
            argumentList: TupleExprElementList([
                TupleExprElement(
                    label: nil,
                    colon: nil,
                    expression: StringLiteralExpr(
                        openDelimiter: nil,
                        openQuote: Tokens.stringQuote,
                        segments: StringLiteralSegments([
                            StringSegment(content: Tokens.stringSegment(message))
                        ]),
                        closeQuote: Tokens.stringQuote,
                        closeDelimiter: nil
                    ),
                    trailingComma: nil
                )
            ]),
            rightParen: Tokens.rightParen,
            trailingClosure: nil,
            additionalTrailingClosures: nil
        )
    }
}
