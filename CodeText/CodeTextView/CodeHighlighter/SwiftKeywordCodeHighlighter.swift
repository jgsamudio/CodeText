//
//  SwiftKeywordCodeHighlighter.swift
//  CodeText
//
//  Created by Jonathan Samudio on 4/24/19.
//  Copyright © 2019 Jonathan Samudio. All rights reserved.
//

import Foundation
import Cocoa

class SwiftKeywordCodeHighlighter: CodeHighlighter {
    
    private let keywords = [
        "func", "extension", "private", "var", "let", "if", "else", "init", "class", "protocol", "while", "lazy",
        "return", "import", "super", "required", "for", "in", "self"
    ]
    
    var attributes: [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.foregroundColor: NSColor(red: 1, green: 0.478, blue: 0.698, alpha: 1)]
    }
    
    func shouldHighlight(text: String) -> Bool {
        return keywords.contains(text)
    }
}
