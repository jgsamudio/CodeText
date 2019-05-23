//
//  TextSeparatorProvider.swift
//  CodeText
//
//  Created by Jonathan Samudio on 4/24/19.
//  Copyright © 2019 Jonathan Samudio. All rights reserved.
//

import Foundation

public protocol TextSeparatorProvider {
    var separators: [String] { get}
    func isSeparator(_ text: String) -> Bool
}

extension TextSeparatorProvider {
    
    public func isSeparator(_ text: String) -> Bool {
        return separators.contains(text)
    }
}
