//
//  SecondViewController.swift
//  ScreenChangeExample
//
//  Created by 송종근 on 2021/06/30.
//

import UIKit

class SecondViewController:UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ThirdViewController {
            destination.label_text = "test"
        }
    }
}
