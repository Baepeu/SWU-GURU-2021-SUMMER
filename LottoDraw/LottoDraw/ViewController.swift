//
//  ViewController.swift
//  LottoDraw
//
//  Created by 송종근 on 2021/06/27.
//

import UIKit
import FMDB

class ViewController: UIViewController {
    var lottoNumbers = Array<Array<Int>>()
    var databasePath = String()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 디비 초기화 함수 호출
        self.initDB()
        // Do any additional setup after loading the view.
        // 데이터베이스 초기화
        // create table
        
        /*
         1. 텍스트 파일 - 다량 대량의 데이터를 관리하기 어렵다.
         2. 엑셀(스프레드시트) - 다량의 데이터 관리를 위한 형태
         3. 데이터베이스 - 대량의 데이터를 효율적으로 저장, 검색, 변경, 삭제
         - 메모장, 알람 - 어떤 상태나 내용을 저장해두려고 한다?!
         - 앱을 껐다가 다시 켜도 보관, 저장되어 있어야 하는 내용이 있다!
         - CoreData
         - 공통된 데이터베이스 설계 -> 같은 데이터베이스 제품 -> sqlite3
         - sqlite3 경량 데이터베이스
         
         데이터베이스(파일) - 테이블(시트) - 컬럼과 로우
         - 앱에서 접근 가능한 데이터베이스 파일을 생성
         - 생성된 파일에 테이블 생성
         - 내용을 저장, 변경, 삭제
         */
    }
    
    func initDB() {
        let fileMgr = FileManager.default
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docDir = dirPaths[0]
        
        databasePath = docDir + "/lotto.db"
        if !fileMgr.fileExists(atPath: databasePath) {
            // 디비 만들기
            let db = FMDatabase(path: databasePath)
            if db.open() {
                // 테이블을 만들기
                // SQL : 질의문
                // 글자를 저장하기 위한 컬럼 타입 : text
                let query = "create table if not exists lotto (id integer primary key autoincrement, num1 integer, num2 integer, num3 integer, num4 integer, num5 integer, num6 integer)"
                if !db.executeStatements(query) {
                    NSLog("디비 생성 실패")
                } else {
                    NSLog("디비 생성 성공")
                }
            }
        } else {
            NSLog("디비파일 있음")
        }
    }


    @IBAction func doLoad(_ sender: Any) {
        print("DoLoad")
        lottoNumbers = Array<Array<Int>>()
        let db = FMDatabase(path: databasePath)
        if db.open() {
            let query = "select * from lotto"
            if let result = db.executeQuery(query, withArgumentsIn: []) {
                while result.next() {
                    var columnArray = Array<Int>()
                    columnArray.append(Int(result.int(forColumn: "num1")))
                    columnArray.append(Int(result.int(forColumn: "num2")))
                    columnArray.append(Int(result.int(forColumn: "num3")))
                    columnArray.append(Int(result.int(forColumn: "num4")))
                    columnArray.append(Int(result.int(forColumn: "num5")))
                    columnArray.append(Int(result.int(forColumn: "num6")))
                    
                    lottoNumbers.append(columnArray)
                }
                self.tableView.reloadData()
            } else {
                NSLog("결과 없음")
            }
        } else {
            NSLog("DB Connection Error")
        }
    }
    
    @IBAction func doDraw(_ sender: Any) {
        print("Draw")
        lottoNumbers = Array<Array<Int>>()
        
        var originalNumbers = Array(1...45)
        var index = 0
        
        for _ in 0...4 {
            originalNumbers = Array(1...45)
            var columnArray = Array<Int>()
            for _ in 0...5 {
                index = Int.random(in: 0..<originalNumbers.count)
                columnArray.append(originalNumbers[index])
                originalNumbers.remove(at: index)
            }
            columnArray.sort()
            lottoNumbers.append(columnArray)
        }
        self.tableView.reloadData()
    }
    
    @IBAction func doSave(_ sender: Any) {
        print("Save")
        let db = FMDatabase(path: databasePath)
        if db.open() {
            try! db.executeUpdate("delete from lotto", values: [])
            for numbers in lottoNumbers {
                let query = "insert into lotto(num1, num2, num3, num4, num5, num6) values (\(numbers[0]),\(numbers[1]),\(numbers[2]),\(numbers[3]),\(numbers[4]),\(numbers[5]))"
                if !db.executeUpdate(query, withArgumentsIn: []) {
                    NSLog("저장 실패")
                } else {
                    NSLog("저장 성공")
                }
            }
        } else {
            NSLog("DB Connection Error")
        }
    }
}

extension ViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 셀이 몇개냐?
        return self.lottoNumbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 셀에 내용을 넣어서 반환
        let cell = tableView.dequeueReusableCell(withIdentifier: "lottoCell", for: indexPath) as! LottoCell
        let numbers = self.lottoNumbers[indexPath.row]
        cell.label01.text = "\(numbers[0])"
        cell.label02.text = "\(numbers[1])"
        cell.label03.text = "\(numbers[2])"
        cell.label04.text = "\(numbers[3])"
        cell.label05.text = "\(numbers[4])"
        cell.label06.text = "\(numbers[5])"
        
        return cell
    }
    
    
}

