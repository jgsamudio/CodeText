//
//  SwiftCommentCodeHightlighter.swift
//  CodeText
//
//  Created by Jonathan Samudio on 4/29/19.
//  Copyright © 2019 Jonathan Samudio. All rights reserved.
//

import Foundation
import Cocoa

public class SwiftCommentCodeHightlighter: CodeHighlighter {
    
    public var attributes: [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.foregroundColor: NSColor(red: 0.498, green: 0.549, blue: 0.596, alpha: 1),
                NSAttributedString.Key.font: NSFont(name: "Menlo", size: 11)!]
    }
    
    public func rangeToHighlight(tokenInfo: TokenInfo, textInfo: TextInfo) -> NSRange? {
        if tokenInfo.currentCharacter == "/" && tokenInfo.peakCharacter == "/" {
            let startCommentIndex = textInfo.range.upperBound-1
            for i in startCommentIndex..<textInfo.characters.count {
                if textInfo.characters[i].string.rangeOfCharacter(from: CharacterSet.newlines) != nil {
                    let rangeLength = i - startCommentIndex
                    return NSMakeRange(startCommentIndex, rangeLength)
                }
            }
            let rangeLength = textInfo.characters.count - startCommentIndex
            return NSMakeRange(startCommentIndex, rangeLength)
        } else {
            var index = textInfo.range.upperBound-1
            while index >= 0 && textInfo.characters[index].string.rangeOfCharacter(from: CharacterSet.newlines) == nil {
                if textInfo.characters[index].string == "/" && textInfo.characters[index+1].string == "/" {
                    return textInfo.range
                }
                index -= 1
            }
        }
        return nil
    }
}
