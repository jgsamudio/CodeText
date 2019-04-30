//
//  SwiftOtherCodeHightlighter.swift
//  CodeText
//
//  Created by Jonathan Samudio on 4/29/19.
//  Copyright © 2019 Jonathan Samudio. All rights reserved.
//

import Foundation
import Cocoa

enum OtherKeywords: String, CaseIterable {
    case `String`
    case `Int`
    case `Bool`
    case `init`
    case `NSTextView`
    case `NSTextStorage`
    case `NSTextStorageEditActions`
    case `NSRange`
    case `NSCoder`
    case `NSMakeRange`
    case `NSTextStorageDelegate`
    case `NSAttributedString`
    case `NSColor`
    case `print`
    case `CGRect`
    case `CaseIterable`
    
    static func shouldHighlight(token: String, peakCharacter: String?, previousToken: String) -> Bool {
        for keyword in OtherKeywords.allCases {
            if keyword.rawValue == token {
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
    
    func rangeToHighlight(tokenInfo: TokenInfo, textInfo: TextInfo) -> NSRange? {
        if OtherKeywords.shouldHighlight(token: tokenInfo.token,
                                         peakCharacter: tokenInfo.peakCharacter,
                                         previousToken: tokenInfo.previousToken) {
            return textInfo.range
        }
        return nil
    }
}
