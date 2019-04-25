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
        
        // MARK: - Injectable Variables
        
        lazy var textSeparatorProvider: TextSeparatorProvider = {
            return SwiftTextSeparatorProvider()
        }()
        
        lazy var highlighterProvider: CodeHighlighterProvider = {
            return CodeHighlighterProvider(defaultAttributes: [NSAttributedString.Key.foregroundColor: NSColor.white],
                                           codeHighlighters: [SwiftKeywordCodeHighlighter()])
        }()
        
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
        
        // TODO: On /t change tab to 4 spaces
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
            
            // Preload the character array
            // Needed for performance.
            let textCharacters = textStorage.characters
            
            // Find the start index based in separators
            while start > 0, !textSeparatorProvider.isSeparator(textCharacters[start].string) {
                start -= 1
            }
            
            // Find the end index based in separators
            var end = editedRange.upperBound
            while end < textCharacters.count, !textSeparatorProvider.isSeparator(textCharacters[end].string) {
                end += 1
            }
            
            let length = (editedRange.lowerBound - start) + editedRange.length + (end - editedRange.upperBound)
            let updatedRange = NSMakeRange(start, (length))
            
            var tempString = ""
            var range = NSMakeRange(updatedRange.location, 0)
            
            print(updatedRange)
            print("Length: \\(updatedRange.length)")
            
            /// Resets the range and the tempString.
            ///
            /// - Parameter offset: Offset of the new start location.
            func reset(offset: Int = 0) {
                range.location += tempString.count + offset
                range.length = 0
                tempString = ""
            }
            
            // Apply Highlight
            for i in updatedRange.location..<(updatedRange.location + updatedRange.length) {
                let currentCharacter = textCharacters[i].string
                if textSeparatorProvider.isSeparator(currentCharacter) {
                    reset(offset: 1)
                } else {
                    tempString += currentCharacter
                    range.length += 1
                    
                    for highlighter in highlighterProvider.codeHighlighters {
                        if highlighter.shouldHighlight(text: tempString) {
                            for (key, value) in highlighter.attributes {
                                textStorage.addAttribute(key, value: value, range: range)
                            }
                            reset()
                        } else {
                            for (key, value) in highlighterProvider.defaultAttributes {
                                textStorage.addAttribute(key, value: value, range: range)
                            }
                        }
                    }
                }
            }
        }
    }
    """
}
