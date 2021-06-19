//
//  FunctionDecl+Sugar.swift
//  

import SwiftSyntax
import SwiftSyntaxBuilder

extension FunctionDecl {

    init(method: APIItem.Method, isOverriden: Bool = false) {
        let parameters = zip(method.arguments, method.arguments.indices).map { argument, index -> FunctionParameter in
            var trailingComma: TokenSyntax?
            if index < method.arguments.count - 1 {
                trailingComma = Tokens.comma
            }

            let typeName = NameTransformer.transformTypeName(argument.type)
            let name = NameTransformer.transformArgumentName(argument.name, argumentTypeName: typeName)
            
            return FunctionParameter(
                attributes: nil,
                firstName: Tokens.identifier(name),
                secondName: nil,
                colon: Tokens.colon,
                type: SimpleTypeIdentifier(typeName: typeName),
                ellipsis: nil,
                defaultArgument: nil,
                trailingComma: trailingComma
            )
        }

        let modifiers: [DeclModifier] = isOverriden ? [.public, .override] : [.public]
        let functionName = NameTransformer.transformFunctionName(method.name)
        let returnTypeName = NameTransformer.transformTypeName(method.returnType)

        self.init(
            attributes: nil,
            modifiers: ModifierList(modifiers),
            funcKeyword: Tokens.func,
            identifier: Tokens.identifier(functionName),
            genericParameterClause: nil,
            signature: FunctionSignature(
                input: ParameterClause(
                    leftParen: Tokens.leftParen,
                    parameterList: FunctionParameterList(parameters),
                    rightParen: Tokens.rightParen
                ),
                asyncOrReasyncKeyword: nil,
                throwsOrRethrowsKeyword: nil,
                output: ReturnClause(
                    arrow: Tokens.arrow.withLeadingTrivia(.spaces(1)),
                    returnType: SimpleTypeIdentifier(typeName: returnTypeName)
                )
            ),
            genericWhereClause: nil,
            body: CodeBlock(
                leftBrace: Tokens.leftBrace.withLeadingTrivia(.spaces(1)),
                statements: CodeBlockItemList([
                    CodeBlockItem(
                        item: FunctionCallExpr.fatalError(message: "Not generated"),
                        semicolon: nil,
                        errorTokens: nil
                    )
                ]),
                rightBrace: Tokens.rightBrace
            )
        )
    }
}

