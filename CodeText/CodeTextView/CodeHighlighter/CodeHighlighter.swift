//
//  CodeHighlighter.swift
//  CodeText
//
//  Created by Jonathan Samudio on 4/24/19.
//  Copyright © 2019 Jonathan Samudio. All rights reserved.
//

import Foundation

protocol CodeHighlighter {
    var attributes: [NSAttributedString.Key: Any] { get }
    func shouldHighlight(text: String) -> Bool
}
