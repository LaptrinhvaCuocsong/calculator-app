//
//  ViewController.swift
//  Calculator
//
//  Created by nguyen manh hung on 5/2/19.
//  Copyright © 2019 nguyen manh hung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var outputLabel: UILabel!
    
    var output: String = "0" {
        willSet {
            outputLabel.text = newValue
        }
        didSet {
            if a != nil && tt != nil {
                b = Double(output)
            }
            else {
                a = Double(output)
            }
        }
    }
    
    var a: Double? {
        didSet {
            b = nil
            tt = nil
        }
    }
    
    var b: Double?
    
    var tt: String?
    
    var resetOutputFlg = false
    
    enum Operator: String {
        case plus = "+"
        case minus = "-"
        case multiply = "X"
        case divide = "/"
        case dividedBySurplus = "%"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outputLabel.text = output
    }
    
    @IBAction func enterNumber(_ sender: UIButton) {
        if (output == "0" && sender.titleLabel!.text! != ".") || resetOutputFlg {
            output = sender.titleLabel!.text!
            resetOutputFlg = false
        }
        else {
            if sender.titleLabel!.text! == "." {
                if output.contains(".") {
                    return
                }
            }
            output += sender.titleLabel!.text!
        }
    }
    
    @IBAction func enterOperator(_ sender: UIButton) {
        if b != nil {
            let rs = calculator(a: a ?? 0.0, tt: tt, b: b)
            tt = nil
            output = String(rs)
        }
        tt = sender.titleLabel!.text!
        resetOutputFlg = true
    }
    
    @IBAction func opposite(_ sender: UIButton) {
        let rs = Double(output)! * -1
        output = String(rs)
    }
    
    @IBAction func resetAll(_ sender: UIButton) {
        output = "0"
        resetOutputFlg = false
    }
    
    @IBAction func calculator(_ sender: UIButton) {
        let rs = calculator(a: a ?? 0.0, tt: tt, b: b)
        tt = nil
        output = String(rs)
    }
    
    func calculator(a: Double, tt: String?, b: Double?) -> Double {
        if tt == Operator.divide.rawValue {
            return a / (b ?? 1.0)
        }
        else if tt == Operator.dividedBySurplus.rawValue {
            return Double(Int(a) % Int(b ?? 1.0))
        }
        else if tt == Operator.minus.rawValue {
            return a - (b ?? 0.0)
        }
        else if tt == Operator.plus.rawValue {
            return a + (b ?? 0.0)
        }
        else if tt == Operator.multiply.rawValue {
            return a * (b ?? 1.0)
        }
        else {
            return a
        }
    }
    
}

