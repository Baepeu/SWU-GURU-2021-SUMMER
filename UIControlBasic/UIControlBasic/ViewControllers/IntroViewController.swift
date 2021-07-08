//
//  IntroViewController.swift
//  UIControlBasic
//
//  Created by 송종근 on 2021/07/08.
//

import UIKit
import SwiftyGif
class IntroViewController:UIViewController {
    @IBOutlet weak var logoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let gif = try UIImage(gifName: "main.gif")
            self.logoImageView.setGifImage(gif, loopCount: -1)
        } catch {
            print(error)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NSLog("before timer")
        let timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { timer in
            NSLog("start timer")
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainView") {
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
}
