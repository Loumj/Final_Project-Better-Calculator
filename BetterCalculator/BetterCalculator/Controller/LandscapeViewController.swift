//
//  LandscapeViewController.swift
//  BetterCalculator
//
//  Created by  on 5/3/24.
//

import UIKit

class LandscapeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var calcField: UITextField!
    
    var currentCalculation: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func zeroButton(_ sender: Any) {
        Logger.shared.log("Zero button pressed")
        appendToCalcField("0")
    }
    
    
    
    @IBAction func oneButton(_ sender: Any) {
        Logger.shared.log("One button pressed")
        appendToCalcField("1")

    }
    
    
    @IBAction func twoButton(_ sender: Any) {
        Logger.shared.log("Two button pressed")
        appendToCalcField("2")
    }
    
    
    
    
    @IBAction func threeButton(_ sender: Any) {
        Logger.shared.log("Three button pressed")
        appendToCalcField("3")
    }
    
    @IBAction func fourButton(_ sender: Any) {
        Logger.shared.log("Four button pressed")
        appendToCalcField("4")
    }
    
    
    
    @IBAction func fiveButton(_ sender: Any) {
        Logger.shared.log("Five button pressed")
        appendToCalcField("5")
    }
    
    @IBAction func sixButton(_ sender: Any) {
        Logger.shared.log("Six button pressed")
        appendToCalcField("6")
    }
    
    @IBAction func sevenButton(_ sender: Any) {
        Logger.shared.log("Seven button pressed")
        appendToCalcField("7")
    }
    
    @IBAction func eightButton(_ sender: Any) {
        Logger.shared.log("Eight button pressed")
        appendToCalcField("8")
    }
    
    
    @IBAction func nineButton(_ sender: Any) {
        Logger.shared.log("Nine button pressed")
        appendToCalcField("9")
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        Logger.shared.log("Backspace button pressed")
        if let text = calcField.text, !text.isEmpty {
                    calcField.text?.removeLast()
                    currentCalculation = String(currentCalculation.dropLast())
                }
    }
    
    @IBAction func enterButton(_ sender: Any)  {
        Logger.shared.log("Equals button pressed")
        guard let calculation = calcField.text, !calculation.isEmpty else {
                resultLabel.text = "Can't compute - no input"
                return
            }
            
            if !isValidExpression(calculation) {
                resultLabel.text = "Can't compute - invalid expression"
                return
            }
            
            if let result = calculate() {
                resultLabel.text = result
            } else {
                resultLabel.text = "Error in calculation"
            }
    }
    
    @IBAction func clearButton(_ sender: Any) {
        Logger.shared.log("Clear button pressed")
        currentCalculation = ""
        calcField.text = ""
        resultLabel.text = ""
    }
    
    @IBAction func parenButton(_ sender: Any) {
        Logger.shared.log("Parentheses button pressed")
        calcField.text = "Feature is in premium version"
          DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
              self.currentCalculation = ""
              self.calcField.text = ""
              self.resultLabel.text = ""
          }
    }
    
    @IBAction func percButton(_ sender: Any) {
        Logger.shared.log("Percentage button pressed")
           if let text = calcField.text, !text.isEmpty {
               appendToCalcField("/100")
           } else {
               print("No number to convert to percentage")
           }
    }
    
    
    
    
    
    @IBAction func divButton(_ sender: Any) {
        Logger.shared.log("Divide button pressed")
        appendToCalcField("/")
    }
    
    @IBAction func multButton(_ sender: Any) {
        Logger.shared.log("Multiply button pressed")
        appendToCalcField("*")
    }
    
    @IBAction func minusButton(_ sender: Any) {
        Logger.shared.log("Minus button pressed")
        appendToCalcField("-")
        
    }
    
    @IBAction func plusButton(_ sender: Any) {
        Logger.shared.log("Plus button pressed")
        appendToCalcField("+")
    }
    
    @IBAction func equalButton(_ sender: Any) {
        appendToCalcField("=")
        
        guard let calculation = calcField.text else {
            resultLabel.text = "Invalid expression"
            return
        }

        let components = calculation.components(separatedBy: "=")
        if components.count == 2 {
            let left = components[0].trimmingCharacters(in: .whitespacesAndNewlines)
            let right = components[1].trimmingCharacters(in: .whitespacesAndNewlines)

            if !left.isEmpty && !right.isEmpty {
                resultLabel.text = "\(left == right)"
            } else {
                resultLabel.text = "Invalid expression"
            }
        } else {
            resultLabel.text = "Invalid expression"
        }
    }
    
    @IBAction func decimalButton(_ sender: Any) {
        Logger.shared.log("Decimal button pressed")
        appendToCalcField(".")
    }
    

    
    func appendToCalcField(_ value: String) {
           calcField.text?.append(value)
           currentCalculation.append(value)
       }

    
    func isValidExpression(_ expression: String) -> Bool {
        let trimmedExpression = expression.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedExpression.isEmpty {
            return false
        }
        
        // Check if the expression starts or ends with non-numeric characters (excluding parentheses)
        let invalidStartEndCharacters = CharacterSet(charactersIn: "+-*/")
        if trimmedExpression.first?.unicodeScalars.contains(where: invalidStartEndCharacters.contains) ?? false
            || trimmedExpression.last?.unicodeScalars.contains(where: invalidStartEndCharacters.contains) ?? false {
            return false
        }
        
       
        let operatorsSet = CharacterSet(charactersIn: "+*/=")
        var previousCharWasOperator = false
        for char in trimmedExpression {
            if char.unicodeScalars.contains(where: operatorsSet.contains) {
                if previousCharWasOperator {
                    return false
                }
                previousCharWasOperator = true
            } else {
                previousCharWasOperator = false
            }
        }
        
        return true
    }
    
    func calculate() -> String? {
        if currentCalculation.contains("=") {
           
            let components = currentCalculation.components(separatedBy: "=")
            if components.count == 2 {
                let leftExpression = NSExpression(format: components[0])
                let rightExpression = NSExpression(format: components[1])
                let leftResult = leftExpression.expressionValue(with: nil, context: nil) as? NSNumber
                let rightResult = rightExpression.expressionValue(with: nil, context: nil) as? NSNumber
                if let leftValue = leftResult?.doubleValue, let rightValue = rightResult?.doubleValue {
                    return "\(leftValue == rightValue)"
                } else {
                    return "Invalid expression"
                }
            } else {
                return "Invalid expression"
            }
        } else {
            if currentCalculation.contains("/") {
                
                let components = currentCalculation.components(separatedBy: "/")
                if components.count == 2 {
                    let leftExpression = NSExpression(format: components[0])
                    let rightExpression = NSExpression(format: components[1])
                    let leftResult = leftExpression.expressionValue(with: nil, context: nil) as? NSNumber
                    let rightResult = rightExpression.expressionValue(with: nil, context: nil) as? NSNumber
                    if let leftValue = leftResult?.intValue, let rightValue = rightResult?.intValue, rightValue != 0 {
                        let quotient = leftValue / rightValue
                        let remainder = leftValue % rightValue
                        if remainder != 0 {
                            return "\(quotient) Remainder \(remainder)"
                        } else {
                            return "\(quotient)"
                        }
                    } else {
                        return "Invalid expression or division by zero"
                    }
                } else {
                    return "Invalid division expression"
                }
            } else {
                
                let expression = NSExpression(format: currentCalculation)
                let result = expression.expressionValue(with: nil, context: nil) as? NSNumber
                return result?.stringValue
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { (context) in
            
        }) { [weak self] (context) in
           
            if size.width < size.height {
              
                self?.navigateToPortraitViewController()
            }
        }
    }
    private func navigateToPortraitViewController() {
       
        if let presentingVC = self.presentingViewController {
            self.dismiss(animated: true, completion: {
                
            })
        }
    }
    
    
    @IBAction func showLog(_ sender: Any) {
        if let logVC = storyboard?.instantiateViewController(withIdentifier: "LogViewController") as? LogViewController {
                navigationController?.pushViewController(logVC, animated: true)
            }
    }
    
}
