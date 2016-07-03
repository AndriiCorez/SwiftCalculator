//
//  CalcModel.swift
//  SwiftCalculator
//
//  Created by Corezina on 7/3/16.
//  Copyright © 2016 Corezina. All rights reserved.
//

import Foundation

func multipy(p1 : Double, p2: Double) -> Double{
    return p1 * p2
}

class CalcModel
{
    private var accumulator: Double = 0.0
    
    private var pending: PendingBinaryOpearationInfo?
    
    private var operations: Dictionary<String,Operation> = [
        "Pi" : Operation.Constant(M_PI),//M_PI,
        "e":Operation.Constant(M_E), //M_E
        "√" : Operation.UnaryOperation(sqrt), //sqrt
        "cos" : Operation.UnaryOperation(cos),
        "±" : Operation.UnaryOperation({ -$0}),
        "×" : Operation.BinaryOperation({$0 * $1}),
        "÷" : Operation.BinaryOperation({$0 / $1}),
        "+" : Operation.BinaryOperation({$0 + $1}),
        "−" : Operation.BinaryOperation({$0 + $1}),
        "=" : Operation.Equals
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Equals
    }
    
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    func performOperation(symbol: String){
        if let operation = operations[symbol]{
            switch operation{
            case .Constant(let constValue): accumulator = constValue
            case .UnaryOperation(let function):accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOpearationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:executePendingBinaryOperation()
            default : break
            }
        }
    }
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    struct PendingBinaryOpearationInfo {
        var binaryFunction: (Double,Double) -> (Double)
        var firstOperand: Double
    }
        
    var result: Double {
        get { return accumulator }
    }
}
