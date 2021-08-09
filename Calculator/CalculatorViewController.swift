//
//  ViewController.swift
//  Calculator
//
//  Created by Salman on 8/8/21.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet var numLabel: UILabel!
    
    var operandOne: Double = 0
    var operation: Character?
    
    var pastCalcs: [String] = []
    
    let nf: NumberFormatter = {
            let nf = NumberFormatter()
            nf.numberStyle = .decimal
            nf.maximumFractionDigits = 7
            return nf
    }()
    
    @IBAction func btnPress(_ sender: UIButton) {
        switch sender.title(for: .normal) {
        case "Clear":
            operandOne = 0
            numLabel.text = "0"
        case "=":
            UpdateResOnLabel()
            operation = nil
        case "+":
            if operation != nil {
                UpdateResOnLabel()
            }
            
            operation = "+"
            operandOne = nf.number(from: numLabel.text!)!.doubleValue
            
            numLabel.text = "0"
        case "-":
            if operation != nil {
                UpdateResOnLabel()
            }
            
            operation = "-"
            operandOne = nf.number(from: numLabel.text!)!.doubleValue
            
            numLabel.text = "0"
        case "x":
            if operation != nil {
                UpdateResOnLabel()
            }
            
            operation = "x"
            operandOne = nf.number(from: numLabel.text!)!.doubleValue
            
            numLabel.text = "0"
        case "/":
            if operation != nil {
                UpdateResOnLabel()
            }
            
            operation = "/"
            operandOne = nf.number(from: numLabel.text!)!.doubleValue
            
            numLabel.text = "0"
        case ".":
            if numLabel.text!.count >= 10 {
                return
            }
            
            if numLabel.text?.range(of: ".") == nil {
                numLabel.text! += "."
            }
        default:
            if numLabel.text!.count >= 11 {
                return
            }
            
            var newNum: Double
            
            if numLabel.text == "0" {
                newNum = Double(sender.title(for: .normal)!)!
            } else if numLabel.text?.last == "." {
                newNum = Double(nf.number(from: numLabel.text!)!.stringValue + "." + sender.title(for: .normal)!)!
            } else {
                newNum = Double(nf.number(from: numLabel.text!)!.stringValue + sender.title(for: .normal)!)!
            }
            
            numLabel.text = nf.string(from: NSNumber(value: newNum))
        }
    }
    
    func UpdateResOnLabel() {
        if let operation = operation {
            
            var newNum: Double
            
            switch operation {
            case "+":
                newNum = operandOne + nf.number(from: numLabel.text!)!.doubleValue
            case "-":
                newNum = operandOne - nf.number(from: numLabel.text!)!.doubleValue
            case "x":
                newNum = operandOne * nf.number(from: numLabel.text!)!.doubleValue
            case "/":
                newNum = operandOne / nf.number(from: numLabel.text!)!.doubleValue
            default:
                return
            }
            
            if newNum.isFinite {
                pastCalcs.append("\(operandOne) \(operation) \(nf.number(from: numLabel.text!)!.doubleValue) = \(newNum)")
                
                numLabel.text = nf.string(from: NSNumber(value: newNum))
            } else {
                let msgBox = UIAlertController(title: "Error", message: "You attemptd to perform calculation with a non-finite number. Value has been set to 0", preferredStyle: UIAlertController.Style.alert)
                msgBox.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(msgBox, animated: true, completion: nil)
                
                pastCalcs.append("\(operandOne) \(operation) \(nf.number(from: numLabel.text!)!.doubleValue) = not finite")
                
                numLabel.text = "0"
            }
        }
    }
    
    @IBAction func deleteOne(_ sender: UIButton) {
        if numLabel.text?.count == 1 {
            numLabel.text = "0"
            return
        }
        
        if numLabel.text?.last == "." {
            numLabel.text = String(numLabel.text!.dropLast())
        } else {
            numLabel.text = nf.string(from: NSNumber(value: Double(nf.number(from: numLabel.text!)!.stringValue.dropLast())!))
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segue = segue.destination as! HistoryViewController
        segue.pastCalcs = pastCalcs
    }
    
}
