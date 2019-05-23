//
//  CodeHighlighter.swift
//  CodeText
//
//  Created by Jonathan Samudio on 4/24/19.
//  Copyright © 2019 Jonathan Samudio. All rights reserved.
//

import Foundation
import Cocoa

public struct TokenInfo {
    public let token: String
    public let currentCharacter: String
    public let peakCharacter: String?
    public let previousToken: String
}

public struct TextInfo {
    public let range: NSRange
    public let characters: [NSTextStorage]
}

public protocol CodeHighlighter {
    var attributes: [NSAttributedString.Key: Any] { get }
    func rangeToHighlight(tokenInfo: TokenInfo, textInfo: TextInfo) -> NSRange?
}
