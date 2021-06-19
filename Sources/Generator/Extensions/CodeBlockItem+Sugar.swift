//
//  CodeBlockItem+Sugar.swift
//

import SwiftSyntax
import SwiftSyntaxBuilder

extension CodeBlockItem {

    init(item: SyntaxBuildable) {
        self.init(item: item, semicolon: nil, errorTokens: nil)
    }
}
