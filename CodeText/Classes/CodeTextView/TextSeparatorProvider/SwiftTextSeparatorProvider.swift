//
//  SwiftTextSeparatorProvider.swift
//  CodeText
//
//  Created by Jonathan Samudio on 4/24/19.
//  Copyright © 2019 Jonathan Samudio. All rights reserved.
//

import Foundation

public struct SwiftTextSeparatorProvider: TextSeparatorProvider {
    
    public let separators = [
        " ", "}", "{", "(", ")", "\n", "\t", ",", ".", "?"
    ]
}
