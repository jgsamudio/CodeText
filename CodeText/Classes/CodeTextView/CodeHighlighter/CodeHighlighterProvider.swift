//
//  CodeHighlighterProvider.swift
//  CodeText
//
//  Created by Jonathan Samudio on 4/24/19.
//  Copyright © 2019 Jonathan Samudio. All rights reserved.
//

import Foundation

public struct CodeHighlighterProvider {
    public let defaultAttributes: [NSAttributedString.Key: Any]
    public let codeHighlighters: [CodeHighlighter]
}
