//
//  IntroViewController.swift
//  BasicSequence
//
//  Created by 송종근 on 2021/06/30.
//

import UIKit
import SwiftyGif

class IntroViewController:UIViewController {
    @IBOutlet weak var intro_image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let gif = try UIImage(gifName: "intro.gif")
            self.intro_image.setGifImage(gif, loopCount: 1)
            self.intro_image.delegate = self
        } catch {
            NSLog("재생불가")
        }
        // 로딩이 필요한 정보가 있다면 이때 로드를 완료하고
        // 화면을 전환한다.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // 몇초후에 화면을 전환하겠다.
        let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
            self.goMainView()
        }
    }
}

extension IntroViewController:SwiftyGifDelegate {
    func gifDidStop(sender: UIImageView) {
        print("gifDidStop")
    }
    
    func goMainView() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainView") {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}
