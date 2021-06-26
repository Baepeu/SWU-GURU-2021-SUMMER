//
//  ViewController.swift
//  UIBasic
//
//  Created by Jake on 2021/06/26.
//

import UIKit

class ViewController: UIViewController {
    /*
     UI 요소들을 연결하는 방식
     IBOutlet : UI 요소를 변수와 연결하는 것
     IBAction : UI 요소의 이벤트를 연결하는 것
     */
    
    @IBOutlet weak var label1: UITextField!
    @IBOutlet weak var label2: UITextField!
    
    let numberFormatter:NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 2
        return nf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("앱 화면이 나타납니다.")
    }

    @IBAction func doConvert(_ sender: UIButton) {
        if let value1 = label1.text, let number1 = Double(value1) {
            // 섭씨 * 1.8 + 32 = 화씨
            let fahrenheit = number1 * 1.8 + 32
            label2.text = numberFormatter.string(from: NSNumber(value: fahrenheit))
            label1.resignFirstResponder()
        }
        
        print("버튼이 눌렸습니다.")
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        label1.resignFirstResponder()
        label2.resignFirstResponder()
    }
    
}

