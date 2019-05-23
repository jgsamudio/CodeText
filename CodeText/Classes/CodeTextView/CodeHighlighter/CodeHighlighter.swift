//
//  CodeHighlighter.swift
//  CodeText
//
//  Created by Jonathan Samudio on 4/24/19.
//  Copyright © 2019 Jonathan Samudio. All rights reserved.
//

import Foundation
import Cocoa

struct TokenInfo {
    let token: String
    let currentCharacter: String
    let peakCharacter: String?
    let previousToken: String
}

struct TextInfo {
    let range: NSRange
    let characters: [NSTextStorage]
}

protocol CodeHighlighter {
    var attributes: [NSAttributedString.Key: Any] { get }
    func rangeToHighlight(tokenInfo: TokenInfo, textInfo: TextInfo) -> NSRange?
}
