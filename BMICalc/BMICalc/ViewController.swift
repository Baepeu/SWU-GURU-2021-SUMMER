//
//  ViewController.swift
//  BMICalc
//
//  Created by Jake on 2021/06/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var bmiField: UITextField!
    
    let numberFormatter:NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 3
        return nf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func bmiCalculation(_ sender: Any) {
        if let heightText = heightField.text, let height = Double(heightText), let weightText = weightField.text, let weight = Double(weightText) {
            let bmi = weight / ((height/100)*(height/100))
            bmiField.text = numberFormatter.string(from: NSNumber(value: bmi))
        }
        
        view.endEditing(true)
        
    }
    
    
    @IBAction func textFieldFinishEdit(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func textEndEditing(_ sender: Any) {
        view.endEditing(true)
    }
    

}

