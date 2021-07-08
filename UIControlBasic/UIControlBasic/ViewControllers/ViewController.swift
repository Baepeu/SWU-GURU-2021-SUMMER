//
//  ViewController.swift
//  UIControlBasic
//
//  Created by 송종근 on 2021/07/08.
//

import UIKit

class ViewController: UIViewController {
    var previousIndex:Int = 0
    var selectedIndex:Int = 0
    
    @IBOutlet var tabBtns: [UIImageView]!
    
    @IBOutlet weak var tabStackView: UIStackView!
    
    
    var viewControllers = [UIViewController]()
    
    static let firstViewController = UIStoryboard(name: "First", bundle: nil).instantiateViewController(withIdentifier: "firstView")
    
    static let secondViewController = UIStoryboard(name: "Second", bundle: nil).instantiateViewController(withIdentifier: "secondView")
    
    static let thirdViewController = UIStoryboard(name: "Third", bundle: nil).instantiateViewController(withIdentifier: "thirdView")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for btn in tabBtns {
            let tap = UITapGestureRecognizer(target:self, action: #selector(tabTapped(_:)))
            btn.isUserInteractionEnabled = true
            btn.addGestureRecognizer(tap)
        }
        
        viewControllers.append(ViewController.firstViewController)
        viewControllers.append(ViewController.secondViewController)
        viewControllers.append(ViewController.thirdViewController)
        
        let currentVC = viewControllers[0]
        currentVC.view.frame = UIApplication.shared.windows[0].frame
        currentVC.didMove(toParent: self)
        self.addChild(currentVC)
        self.view.addSubview(currentVC.view)
        self.view.bringSubviewToFront(tabStackView)
    }
    
    @objc func tabTapped(_ sender:UITapGestureRecognizer) {
        // 탭 버튼을 터치하면 화면전환.
        NSLog("탭탭탭!!")
        if let tag = sender.view?.tag {
            previousIndex = selectedIndex
            selectedIndex = tag
            
            let previousVC = viewControllers[previousIndex]
            previousVC.willMove(toParent: self)
            previousVC.view.removeFromSuperview()
            previousVC.removeFromParent()
            
            let currentVC = viewControllers[selectedIndex]
            currentVC.view.frame = UIApplication.shared.windows[0].frame
            currentVC.didMove(toParent: self)
            self.addChild(currentVC)
            self.view.addSubview(currentVC.view)
            
            self.view.bringSubviewToFront(tabStackView)
        }
    }

}

