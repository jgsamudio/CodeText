//
//  CodeTextView.swift
//  CodeText
//
//  Created by Jonathan Samudio on 4/24/19.
//  Copyright © 2019 Jonathan Samudio. All rights reserved.
//

import Foundation
import Cocoa

class CodeTextView: NSTextView {
    
    // Programmatic initialization
    init() {
        super.init(frame: CGRect.zero)
        initialize()
    }
    
    // Storyboard initialization
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
}

private extension CodeTextView {
    
    func initialize() {
        delegate = self
    }
}

extension CodeTextView: NSTextViewDelegate {
    
    // Delegate only.  If characters are changing, replacementString is what will replace the affectedCharRange.  If attributes only are changing, replacementString will be nil.  Will not be called if textView:shouldChangeTextInRanges:replacementStrings: is implemented.
    func textView(_ textView: NSTextView, shouldChangeTextIn affectedCharRange: NSRange, replacementString: String?) -> Bool {
        print(replacementString!)
        return true
    }
}

class CodeHighlighter {
    
    
}
