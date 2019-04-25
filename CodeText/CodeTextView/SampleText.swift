//
//  SampleText.swift
//  CodeText
//
//  Created by Jonathan Samudio on 4/24/19.
//  Copyright © 2019 Jonathan Samudio. All rights reserved.
//

import Foundation

struct SampleTexts {
    static let sampleFileText = """
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
    }

    private extension CodeTextView {
        
        func initialize() {
            textStorage?.delegate = self
            string = SampleTexts.sampleFileText
        }
    }

    extension CodeTextView: NSTextStorageDelegate {
        
        // Post Processing
        // https://developer.apple.com/documentation/uikit/nstextstoragedelegate/1534375-textstorage
        func textStorage(_ textStorage: NSTextStorage,
                         didProcessEditing editedMask: NSTextStorageEditActions,
                         range editedRange: NSRange,
                         changeInLength delta: Int) {
            
            var start = editedRange.lowerBound + min(delta, 0)
            if start < 0 {
                return
            }
            
            while start > 0, textStorage.characters[start].string != " " {
                start -= 1
            }
            
            var end = editedRange.upperBound
            
            while end < textStorage.characters.count, textStorage.characters[end].string != " " {
                end += 1
            }
            
            let length = (editedRange.lowerBound - start) + editedRange.length + (end - editedRange.upperBound)
            let updatedRange = NSMakeRange(start, (length))
            
            var tempString = ""
            var range = NSMakeRange(updatedRange.location, 0)
            
            // Preload the character array
            // Needed for performance.
            let textCharacters = textStorage.characters
            print(updatedRange)
            for i in updatedRange.location..<(updatedRange.location + updatedRange.length) {
                let currentCharacter = textCharacters[i].string
                if currentCharacter == " " {
                    // Reset the range
                    // Space of the space +1
                    range.location += tempString.count + 1
                    range.length = 0
                    tempString = ""
                } else {
                    tempString += currentCharacter
                    range.length += 1

                    if tempString == "func" ||
                        tempString == "extension" ||
                        tempString == "var" ||
                        tempString == "if" ||
                        tempString == "else" {
                        textStorage.addAttribute(NSAttributedString.Key.foregroundColor, value: NSColor.red, range: range)

                        // Reset the range
                        range.location += tempString.count
                        range.length = 0
                        tempString = ""
                    } else {
                        print(range)
                        textStorage.addAttribute(NSAttributedString.Key.foregroundColor, value: NSColor.white, range: range)
                    }
                }
            }
        }
    }

    class CodeHighlighter {
        
        
    }
    """
}
