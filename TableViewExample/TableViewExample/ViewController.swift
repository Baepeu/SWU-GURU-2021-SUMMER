//
//  ViewController.swift
//  TableViewExample
//
//  Created by 송종근 on 2021/01/06.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    var datasource:[String] = []
    // var datasource = [String]()
    @IBOutlet weak var memoText: UITextField!
    
    override func viewDidLoad() {
        // 뷰 인스턴스가 메모리에 올라왔고, 아직 화면은 뜨지 않은 상황
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .cyan
        refreshControl.addTarget(self, action: #selector(fetchData(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        let userDefault = UserDefaults.standard
        if let value = userDefault.array(forKey: "MemoData") as? [String] {
            self.datasource = value
        }
    }
    
    @objc func fetchData(_ sender:Any) {
        tableView.refreshControl?.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func addMemo(_ sender: UIButton) {
        guard let memo = memoText.text, memo != "" else {
            return
        }
        // 변수에 저장하기
        self.datasource.append(memo)
        memoText.text = ""
        
        self.saveData()
        self.tableView.reloadData()
    }
    
    func saveData() {
        let userDefault = UserDefaults.standard
        userDefault.setValue(datasource, forKey: "MemoData")
        userDefault.synchronize()
    }
    
}

extension ViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath) as! memoCell
        let row = indexPath.row
        cell.memoLabel.text = "\(datasource[row])"
        cell.numLabel.text = "\(row+1)"
        return cell
    }

    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let fromRow = sourceIndexPath.row
        let toRow = destinationIndexPath.row
        let data = datasource[fromRow]
        datasource.remove(at: fromRow)
        datasource.insert(data, at: toRow)
        saveData()
        tableView.reloadData()
    }
    
        
}

extension ViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    // 셀 오른쪽 끝에 나타날 버튼들
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let btnEdit = UIContextualAction(style: .normal, title: "Edit") { (action, view, completion) in
            
            let editAlert = UIAlertController(title: "Edit Memo", message: "change your memo", preferredStyle: .alert)
            
            editAlert.addTextField { (textField) in
                textField.text = self.datasource[indexPath.row]
            }
            editAlert.addAction(UIAlertAction(title: "Modify", style: .default, handler: { (action) in
                if let fields = editAlert.textFields, let textField = fields.first, let text = textField.text {
                    self.datasource[indexPath.row] = text
                    //self.tableView.reloadData()
                    self.tableView.reloadRows(at: [indexPath], with: .fade)
                    self.saveData()
                }
            }))
            editAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(editAlert, animated: true, completion: nil)
            completion(true)
        }
        
        let btnDelete = UIContextualAction(style: .destructive, title: "Del") { (action, view, completion) in
            
            let row = indexPath.row
            self.datasource.remove(at: row)
            //tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            self.saveData()
            completion(true)
        }
        btnEdit.backgroundColor = .blue
        btnDelete.backgroundColor = .black
        return UISwipeActionsConfiguration(actions: [btnDelete,btnEdit])
    }
    
    // 셀 왼쪽 시작부분에 나타날 버튼들
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let btnShare = UIContextualAction(style: .normal, title: "Share") { (action, view, completion) in
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [btnShare])
    }
    
    @IBAction func changeEditing(_ sender: UIBarButtonItem) {
        //self.tableView.isEditing = !self.tableView.isEditing
        // toggle swift 4.2 추가됨.
        self.tableView.isEditing.toggle()
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        tableView.deselectRow(at: indexPath, animated: false)
        performSegue(withIdentifier: "goDetail", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.frame.height / 12
    }
    
}
