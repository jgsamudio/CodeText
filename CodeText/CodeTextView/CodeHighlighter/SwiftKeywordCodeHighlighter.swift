//
//  SwiftKeywordCodeHighlighter.swift
//  CodeText
//
//  Created by Jonathan Samudio on 4/24/19.
//  Copyright © 2019 Jonathan Samudio. All rights reserved.
//

import Foundation
import Cocoa

enum Keywords: String, CaseIterable {
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
    
    static func shouldHighlight(text: String, peakCharacter: String?, previousToken: String) -> Bool {
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

class SwiftKeywordCodeHighlighter: CodeHighlighter {
    
    var attributes: [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.foregroundColor: NSColor(red: 1, green: 0.478, blue: 0.698, alpha: 1)]
    }
    
    func shouldHighlight(text: String, peakCharacter: String?, previousToken: String) -> Bool {
        return Keywords.shouldHighlight(text: text, peakCharacter: peakCharacter, previousToken: previousToken)
    }
}

enum OtherKeywords: String, CaseIterable {
    case `String`
    case `Int`
    case `Bool`
    case `init`
    
    static func shouldHighlight(text: String, peakCharacter: String?, previousToken: String) -> Bool {
        for keyword in OtherKeywords.allCases {
            if keyword.rawValue == text {
                if keyword == .`init` && previousToken == Keywords.`super`.rawValue {
                    return true
                }
                return SwiftTextSeparatorProvider().isSeparator(peakCharacter ?? " ")
            }
        }
        return false
    }
}

class SwiftOtherCodeHightlighter: CodeHighlighter {
    
    var attributes: [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.foregroundColor: NSColor(red: 0.505, green: 0.764, blue: 0.717, alpha: 1)]
    }
    
    func shouldHighlight(text: String, peakCharacter: String?, previousToken: String) -> Bool {
        return OtherKeywords.shouldHighlight(text: text, peakCharacter: peakCharacter, previousToken: previousToken)
    }
}
