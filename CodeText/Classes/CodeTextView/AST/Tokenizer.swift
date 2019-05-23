//
//  Tokenizer.swift
//  CodeText
//
//  Created by Jonathan Samudio on 4/25/19.
//  Copyright © 2019 Jonathan Samudio. All rights reserved.
//

import Foundation

enum TokenType: String {
    case integer
    case plus
    case minus
    case eof
}

struct Token {
    let type: TokenType
    let value: Any?
}

class Interpreter {
    
    private let text: String
    
    private var pos: Int
    private var currentToken: Token?
    private var currentChar: String?
    
    init(text: String) {
        self.text = text
        self.pos = 0
        
        currentToken = nil
        currentChar = getCurrentChar()
    }
    
    // MARK: - Lexer Code
    
    func advance() {
        pos += 1
        if pos > text.count-1 {
            currentChar = nil
        } else {
            currentChar = getCurrentChar()
        }
    }
    
    func skipWhitespace() {
        while currentChar != nil, currentChar == " " {
            advance()
        }
    }
    
    func integer() -> Int {
        var result = ""
        while let currentChar = currentChar, Int(currentChar) != nil {
            result += currentChar
            advance()
        }
        return Int(result)!
    }
    
    /*
     Lexical analyzer (also known as scanner or tokenizer)
     
     This method is responsible for breaking a sentence
     apart into tokens.
     */
    func getNextToken() -> Token {
        while let currentChar = currentChar {
            if currentChar == " " {
                skipWhitespace()
                continue
            }
            
            if Int(currentChar) != nil {
                // No need to advance as the integer() function is advancing
                return Token(type: .integer, value: integer())
            }
            
            if currentChar == "+" {
                advance()
                return Token(type: .plus, value: "+")
            }
            
            if currentChar == "-" {
                advance()
                return Token(type: .minus, value: "-")
            }
            // ERROR
        }
        return Token(type: .eof, value: nil)
    }
    
    // MARK: - Parser / Interpreter Code
    
    /*
     # compare the current token type with the passed token
     # type and if they match then "eat" the current token
     # and assign the next token to the self.current_token,
     # otherwise raise an exception.
    */
    func eat(tokenType: TokenType) {
        if let currentToken = currentToken, currentToken.type == tokenType {
            self.currentToken = getNextToken()
        } else {
            // Error
        }
    }
    
    func term() -> Any? {
        let intValue = currentToken?.value
        eat(tokenType: .integer)
        return intValue
    }
    
    /*
     Parser / Interpreter
     
     expr -> INTEGER PLUS INTEGER
     expr -> INTEGER MINUS INTEGER
     */
    func expr() -> Any? {
        // Parser
        
        // set current token to the first token taken from the input
        currentToken = getNextToken()
        
        var result = term()
        while currentToken?.type == .plus || currentToken?.type == .minus {
            let token = currentToken
            if token?.type == .plus {
                eat(tokenType: .plus)
                if let resultValue = result as? Int, let termValue = term() as? Int {
                    result = resultValue + termValue
                }
            } else if token?.type == .minus {
                eat(tokenType: .minus)
                if let resultValue = result as? Int, let termValue = term() as? Int {
                    result = resultValue - termValue
                }
            }
        }
        return result
    }

// PART 2
//    /*
//     Parser / Interpreter
//
//     expr -> INTEGER PLUS INTEGER
//     expr -> INTEGER MINUS INTEGER
//    */
//    func expr() -> Int {
//        // Parser
//
//        // set current token to the first token taken from the input
//        currentToken = getNextToken()
//
//        // we expect the current token to be an integer
//        let left = currentToken
//        eat(tokenType: .integer)
//
//        // we expect the current token to be either a '+' or '-'
//        let op = currentToken
//        if op?.type == .plus {
//            eat(tokenType: .plus)
//        } else {
//            eat(tokenType: .minus)
//        }
//
//        // we expect the current token to be an integer
//        let right = currentToken
//        eat(tokenType: .integer)
//
//        guard let leftInteger = left?.value as? Int,
//            let rightInteger = right?.value as? Int else {
//            fatalError()
//        }
//
//        // Interpreter
//        if op?.type == .plus {
//            return leftInteger + rightInteger
//        } else {
//            return leftInteger - rightInteger
//        }
//    }
}

private extension Interpreter {
    
    func getCurrentChar() -> String {
        let startIndex = text.index(text.startIndex, offsetBy: pos)
        return String(text[startIndex])
    }
}
