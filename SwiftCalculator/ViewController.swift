//
//  ViewController.swift
//  SwiftCalculator
//
//  Created by Corezina on 6/26/16.
//  Copyright © 2016 Corezina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var display: UILabel!
    
    private var isUserIsInTheMiddleOfTyping = false
    private var displayValue: Double{
        get{ return Double(display.text!)!}
        set{ display.text = String(newValue)}
    }
    private var calcModel : CalcModel = CalcModel()
    
    @IBAction private func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!

        if isUserIsInTheMiddleOfTyping{
            let textCurrentlyDisplayed = display.text!
            display.text = textCurrentlyDisplayed + digit
        } else {
            display.text = digit
        }
        
        isUserIsInTheMiddleOfTyping = true
    }

    @IBAction private func performOperation(sender: UIButton) {
        if isUserIsInTheMiddleOfTyping{
            calcModel.setOperand(displayValue)
        }
        isUserIsInTheMiddleOfTyping = false
        if let mathSymbol = sender.currentTitle{
            calcModel.performOperation(mathSymbol)
            }
        displayValue = calcModel.result
    }
}

