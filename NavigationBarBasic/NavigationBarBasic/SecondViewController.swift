//
//  SecondViewController.swift
//  NavigationBarBasic
//
//  Created by 송종근 on 2021/06/30.
//

import UIKit

class SecondViewController:UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Test2"
    }
}
