//
//  ViewController.swift
//  FirebaseBasic
//
//  Created by 송종근 on 2021/01/13.
//

import UIKit
import FirebaseUI

class ViewController: UIViewController, FUIAuthDelegate {
    
    let authUI = FUIAuth.defaultAuthUI()
    var handle:AuthStateDidChangeListenerHandle!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // You need to adopt a FUIAuthDelegate protocol to receive callback
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let currentUser = auth.currentUser {
                // 로그인이 되어있는 상태
                if let displayName = currentUser.displayName {
                    let alertController = UIAlertController(title: "Welcome", message: "\(displayName)! Welcome!", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertController, animated: false, completion: nil)
                }
            } else {
                // 로그아웃이 되어있는 상태
                self.authUI!.delegate = self
                let providers: [FUIAuthProvider] = [
                  FUIEmailAuth(),
                    FUIGoogleAuth(),
                    FUIOAuth.appleAuthProvider(),
                ]
                self.authUI!.providers = providers
                
                let authViewController = self.authUI!.authViewController()
                authViewController.modalPresentationStyle = .fullScreen
                
                self.present(authViewController, animated: true, completion: nil)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    // 로그인이 안되어 있으면 무조건 로그인 창을 켜라
    // 로그 아웃 기능 실행 후에 로그인 창을 띄워라
    // 한쪽에 앱을 켜놓고 -> 다른쪽에 로그인을 했다.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        print("sign in")
        print(authDataResult)
    }
    
    
    
    @IBAction func doSignOut(_ sender: UIButton) {
        try? authUI?.signOut()
    }
    
}

extension FUIAuthBaseViewController {
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.leftBarButtonItem = nil
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
