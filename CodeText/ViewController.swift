//
//  ViewController.swift
//  CodeText
//
//  Created by Jonathan Samudio on 4/24/19.
//  Copyright © 2019 Jonathan Samudio. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let interpreter = Interpreter(text: "17 - 3 + 6")
        let result = interpreter.expr()
        print(result)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

