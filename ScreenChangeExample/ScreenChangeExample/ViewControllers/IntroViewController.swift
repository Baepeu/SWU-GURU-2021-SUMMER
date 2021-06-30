//
//  IntroViewController.swift
//  ScreenChangeExample
//
//  Created by 송종근 on 2021/06/30.
//

import UIKit

class IntroViewController:UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NSLog("view appear")
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(identifier: "firstScreen")
            
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
        }
    }
}
