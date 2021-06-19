//
//  APIGenerator.swift
//

import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder

final class APIFilesGenerator {

    private let api: API

    init(api: API) {
        self.api = api
    }

    func generateFiles(at directoryURL: URL) throws {
        try api.items.forEach { item in
            let fileURL = directoryURL
                .appendingPathComponent(item.name)
                .appendingPathExtension("swift")

            let syntax = buildSyntax(for: item)
            try syntax.write(toFileAt: fileURL)
        }
    }

    private func buildSyntax(for item: APIItem) -> Syntax {
        let syntax: SyntaxBuildable

        if item.name == "GlobalConstants" {
            syntax = EnumDecl(name: item.name, items: item.sortedConstants)
        } else {
            syntax = generateSyntax(for: item)
        }

        let leadingTrivia = Trivia(pieces: [
            .lineComment("//\n"),
            .lineComment("// \(item.name).swift is generated. DO NOT EDIT!\n"),
            .lineComment("//\n"),
            .newlines(1)
        ])

        return syntax.buildSyntax(format: .init(), leadingTrivia: leadingTrivia)
    }

    private func generateSyntax(for item: APIItem) -> SyntaxBuildable {
        var members = [MemberDeclListItem]()

        if !item.constants.isEmpty {
            let `enum` = EnumDecl(name: "Constants", items: item.sortedConstants)
            members.append(MemberDeclListItem(decl: `enum`))
        }

        if !item.enums.isEmpty {
            members += item.enums.map { `enum` in
                MemberDeclListItem(decl: EnumDecl(enum: `enum`))
            }
        }

        if !item.methods.isEmpty {
            members += item.methods.map { method -> MemberDeclListItem in
                let isOverriden = api.isMethodOverriden(method, in: item)
                return MemberDeclListItem(decl: FunctionDecl(method: method, isOverriden: isOverriden))
            }
        }

        let classDecl = ClassDecl(
            name: item.name,
            baseClassName: item.baseClassName,
            members: members
        )

        return CodeBlockItemList([
            CodeBlockItem(item: ImportDecl(name: "CGodot", trailingTrivia: .newlines(1))),
            CodeBlockItem(item: classDecl)
        ])
    }
}

private extension MemberDeclListItem {

    init(decl: DeclBuildable) {
        self.init(decl: decl, semicolon: nil)
    }
}

private extension ImportDecl {

    init(name: String, trailingTrivia: Trivia = []) {
        self.init(
            attributes: nil,
            modifiers: nil,
            importTok: Tokens.import,
            importKind: nil,
            path: AccessPath([
                AccessPathComponent(
                    name: Tokens.identifier(name).withTrailingTrivia(trailingTrivia),
                    trailingDot: nil
                )
            ])
        )
    }
}
