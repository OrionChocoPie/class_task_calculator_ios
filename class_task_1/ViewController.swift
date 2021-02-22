//
//  ViewController.swift
//  class_task_1
//
//  Created by Admin on 16.02.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var stillTyping = false
    var dotIsPlaced = false
    var firstOperand = 0.0
    var secondOperand = 0.0
    var operationSign = ""
    
    var currentInput: Double {
        get {
            return Double(label.text!)!
        }
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray[1] == "0" {
                label.text = "\(valueArray[0])"
            } else {
                label.text = "\(newValue)"
            }
            
            stillTyping = false
        }
    }

    @IBAction func clearSum(_ sender: Any) {
        firstOperand = 0.0
        secondOperand = 0.0
        currentInput = 0.0
        label.text = "0"
        operationSign = ""
        stillTyping = false
        dotIsPlaced = false
    }
    
    @IBAction func changeSign(_ sender: Any) {
        currentInput = -currentInput
    }
    
    @IBAction func percentageNumber(_ sender: UIButton) {
        if firstOperand == 0 {
            currentInput /= 100
        } else {
            secondOperand = firstOperand * currentInput / 100
        }
    }
    
    @IBAction func doOperation(_ sender: UIButton) {
        operationSign = sender.currentTitle!
        firstOperand = currentInput
        stillTyping = false
        dotIsPlaced = false
    }
    
    func operateWithTwoOperands(operation: (Double, Double) -> Double) {
        currentInput = operation(firstOperand, secondOperand)
        stillTyping = false
    }
    
    @IBAction func calculate(_ sender: UIButton) {
        if stillTyping {
            secondOperand = currentInput
        }
        
        dotIsPlaced = false
        
        switch operationSign {
        case "/":
            operateWithTwoOperands {$0 / $1}
        case "x":
            operateWithTwoOperands {$0 * $1}
        case "-":
            operateWithTwoOperands {$0 - $1}
        case "+":
            operateWithTwoOperands {$0 + $1}
        default: break
        }
    }
    
    @IBAction func pressNumber(_ sender: UIButton) {
        if stillTyping {
            label.text = label.text! + sender.currentTitle!
        } else {
            label.text = sender.currentTitle!
            stillTyping = true
        }
    }
    
    @IBAction func pressComma(_ sender: UIButton) {
        if stillTyping && !dotIsPlaced {
            label.text = label.text! + "."
            dotIsPlaced = true
        } else if !stillTyping && !dotIsPlaced {
            label.text = "0."
        }
    }
    
}

