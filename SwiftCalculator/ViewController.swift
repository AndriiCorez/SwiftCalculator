//
//  ViewController.swift
//  SwiftCalculator
//
//  Created by Corezina on 6/26/16.
//  Copyright © 2016 Corezina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var isUserIsInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!

        if isUserIsInTheMiddleOfTyping{
            let textCurrentlyDisplayed = display.text!
            display.text = textCurrentlyDisplayed + digit
        } else {
            display.text = digit
        }
        
        isUserIsInTheMiddleOfTyping = true
    }

    @IBAction func performOperation(sender: UIButton) {
        isUserIsInTheMiddleOfTyping = false
        
        if let mathSymbol = sender.currentTitle{
            if mathSymbol == "Pi"{
                display.text = String(M_PI)
            }
        }
    }
}

