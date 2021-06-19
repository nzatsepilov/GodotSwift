//
//  SourceFile+Sugar.swift
//  
//
//  Created by Nikita Zatsepilov on 23.05.2021.
//

import SwiftSyntax
import SwiftSyntaxBuilder

extension SourceFile {

    init(items: CodeBlockItem...) {
        self.init(statements: CodeBlockItemList(items), eofToken: Tokens.unknown("\n"))
    }
}
