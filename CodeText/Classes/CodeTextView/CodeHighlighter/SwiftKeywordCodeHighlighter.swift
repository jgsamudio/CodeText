//
//  SwiftKeywordCodeHighlighter.swift
//  CodeText
//
//  Created by Jonathan Samudio on 4/24/19.
//  Copyright © 2019 Jonathan Samudio. All rights reserved.
//

import Foundation
import Cocoa

public enum Keywords: String, CaseIterable {
    case `func`
    case `extension`
    case `private`
    case `var`
    case `let`
    case `if`
    case `else`
    case `init`
    case `protocol`
    case `while`
    case `lazy`
    case `return`
    case `import`
    case `super`
    case `required`
    case `for`
    case `in`
    case `self`
    case `class`
    case `nil`
    
    public static func shouldHighlight(text: String, peakCharacter: String?, previousToken: String) -> Bool {
        for keyword in Keywords.allCases {
            if keyword.rawValue == text {
                if keyword == .`init` && previousToken == Keywords.`super`.rawValue {
                    return false
                }
                return SwiftTextSeparatorProvider().isSeparator(peakCharacter ?? " ")
            }
        }
        return false
    }
}

public class SwiftKeywordCodeHighlighter: CodeHighlighter {
    
    public var attributes: [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.foregroundColor: NSColor(red: 1, green: 0.478, blue: 0.698, alpha: 1)]
    }
    
    public func rangeToHighlight(tokenInfo: TokenInfo, textInfo: TextInfo) -> NSRange? {
        if Keywords.shouldHighlight(text: tokenInfo.token,
                                    peakCharacter: tokenInfo.peakCharacter,
                                    previousToken: tokenInfo.previousToken) {
            return textInfo.range
        }
        return nil
    }
}
