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
    
    // TODO: Make Protocol
    private var highlighter = CodeHighlighter()
    
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
    
    
    override func didChangeText() {
        textStorage?.words.forEach { print($0) }
        
        updateText()
    }
}

private extension CodeTextView {
    
    func initialize() {
        delegate = self
        textStorage?.delegate = self
    }
    
    func updateText() {
//        setTextColor(NSColor.red, range: NSRange(location: 0, length: 1))
//        textStorage?.words.forEach {
////            print($0)
//            if $0.delegate == 'func' {
//                setTextColor(NSColor.red, range: NSRange(location: 0, length: 1))
//            }
//        }
    }
}

extension CodeTextView: NSTextStorageDelegate {
    
    // Post Processing
    // https://developer.apple.com/documentation/uikit/nstextstoragedelegate/1534375-textstorage
    func textStorage(_ textStorage: NSTextStorage,
                     didProcessEditing editedMask: NSTextStorageEditActions,
                     range editedRange: NSRange,
                     changeInLength delta: Int) {
        
//        textStorage.words.forEach {
//            if $0.string == "func" {
//                $0.addAttribute(NSAttributedString.Key.foregroundColor, value: NSColor.red, range: NSMakeRange(0, $0.length))
//            }
//        }
        
        var start = editedRange.lowerBound + min(delta, 0)
        if start < 0 {
            return
        }
        
        while start > 0, textStorage.characters[start].string != " " {
            start -= 1
        }
        
        let length = (editedRange.lowerBound - start) + editedRange.length
        let updatedRange = NSMakeRange(start, (length))
        
//        let attrString = textStorage.attributedSubstring(from: updatedRange).string
        
        var tempString = ""
        var range = NSMakeRange(updatedRange.location, 0)
        print(range)
        
        for i in updatedRange.location..<(updatedRange.location + updatedRange.length) {
            let currentCharacter = textStorage.characters[i].string
            print(currentCharacter)
            
            if currentCharacter == " " {
                range = NSMakeRange(range.location + tempString.count, 0)
                tempString = ""
            } else {
                tempString += currentCharacter
                range = NSMakeRange(range.location, range.length + 1)
                
                if tempString == "func" ||
                    tempString == "extension" ||
                    tempString == "var" ||
                    tempString == "if" ||
                    tempString == "else" {
                    textStorage.addAttribute(NSAttributedString.Key.foregroundColor, value: NSColor.red, range: range)
                } else {
                    textStorage.addAttribute(NSAttributedString.Key.foregroundColor, value: NSColor.white, range: range)
                }
            }
        }
    }
}

extension CodeTextView: NSTextViewDelegate {
    
    // Delegate only.  If characters are changing, replacementString is what will replace the affectedCharRange.
    // If attributes only are changing, replacementString will be nil.  Will not be called if
    // textView:shouldChangeTextInRanges:replacementStrings: is implemented.
    func textView(_ textView: NSTextView,
                  shouldChangeTextIn affectedCharRange: NSRange,
                  replacementString: String?) -> Bool {
//        print(replacementString!)
        return true
    }
    
//    func textView(_ textView: NSTextView,
//                  shouldChangeTypingAttributes oldTypingAttributes: [String : Any] = [:],
//                  toAttributes newTypingAttributes: [NSAttributedString.Key : Any] = [:]) -> [NSAttributedString.Key : Any] {
//        print(oldTypingAttributes)
//        print(newTypingAttributes)
//        return newTypingAttributes
//    }
}

class CodeHighlighter {
    
    
}
