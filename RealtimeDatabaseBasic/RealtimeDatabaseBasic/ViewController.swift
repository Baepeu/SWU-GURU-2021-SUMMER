//
//  ViewController.swift
//  RealtimeDatabaseBasic
//
//  Created by 송종근 on 2021/01/17.
//

import UIKit

import FirebaseDatabase

class ViewController: UIViewController {
    
    var ref: DatabaseReference!
    var refHandle : DatabaseHandle!
    var ref2:DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // FMDB
        /*
         1. 데이터베이스가 저장될 파일을 만든다.
         2. 데이터베이스에 연결
         3. 데이터베이스 초기화
         4. 내용을 기록하고 지우고 수정하고
         */
        
        /*
           Primary Key : 주키
           Foreign Key : 외래키
         */
        ref = Database.database().reference()
        print("1")
        // 새로 데이터 넣을 때 setValue
//        guard let key = ref.child("posts").childByAutoId().key else { return }
//        let post = ["username": "carrotcarrot",
//                    "title": "title"
//                    ]
//        let childUpdates = ["/posts/\(key)": post,
//                            "/users/carrotcarrot/posts/\(key)/": post]
//        ref.updateChildValues(childUpdates)
        
        let testQuery = (ref.child("users")).queryOrdered(byChild: "username")
        testQuery.observe(.value) { (snapshot) in
            let testDict = snapshot.value as? [String : AnyObject] ?? [:]
            print(testDict)
        }
        
        /*
            CRUD
            C : Create
            R : Read
            U : Update
            D : Delete
         
         */
//
//        ref.child("users/\(key)").setValue(["msg":"Hi","username":"carrotcarrot","date":Int(Date().timeIntervalSince1970)]) {
//            (error:Error?, ref:DatabaseReference) in
//              if let error = error {
//                print("Data could not be saved: \(error).")
//               } else {
//                let alertVC = UIAlertController(title: "Complete", message: "Data saved!!", preferredStyle: .alert)
//                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//                self.present(alertVC, animated: true, completion: nil)
//              }
//        }
        
        // 있는 데이터를 수정할 때 updateChildValues
        // ref.child("users/1122334455/username").updateChildValues(["test":"aaaaa"])
        
        print("2")
        // 비동기
        // 순차, 분기, 반복
        // 1 -> 2 -> 3 -> 4
        // 바뀌면 전체 데이터를 다 가져온다.
        ref2 = ref.child("users/1122334455")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 화면이 나타나기 직전에 관찰자를 설정한다.
        print("옵저버 등록")
        refHandle = ref2.observe(DataEventType.value, with: { (snapshot) in
          let postDict = snapshot.value as? [String : AnyObject] ?? [:]
          //print(postDict)
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // 화면이 사라지고 나면 옵저버를 삭제한다.
        print("옵저버 삭제")
        //ref2.removeObserver(withHandle: refHandle)
    }


    @IBAction func pressBtn(_ sender: UIButton) {
        print("button pressed")
        // 내가 어떤 액션을 취했을 때 혹은 특정 순간에 딱 한번만 데이터를 불러오고 싶을 때
        ref2.observeSingleEvent(of: .value) { (snapshop) in
            let data = snapshop.value as? [String:AnyObject] ?? [:]
            print(data)
        }
    }
    
    @IBAction func removeData(_ sender: Any) {
        print("remove button pressed")
        ref.child("users/1122334455/username").child("date").removeValue() {
            (error:Error?, ref:DatabaseReference) in
              if let error = error {
                print("Data could not be saved: \(error).")
              } else {
                let alertVC = UIAlertController(title: "Complete", message: "Data removed!!", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertVC, animated: true, completion: nil)
              }
        }
    }
    
    
    
}

