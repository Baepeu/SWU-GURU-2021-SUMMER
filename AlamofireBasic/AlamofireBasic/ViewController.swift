//
//  ViewController.swift
//  AlamofireBasic
//
//  Created by 송종근 on 2021/01/10.
//

import UIKit
import Alamofire
import AlamofireImage
import NVActivityIndicatorView

class ViewController: UIViewController {
    
    var person_data = [PersonInfo]()
    var indicator:NVActivityIndicatorView!
    @IBOutlet weak var personCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        indicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), type: .lineScalePulseOut, color: .white, padding: self.view.frame.width/2 - 40)
        indicator.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    
        self.view.addSubview(indicator)
        self.view.bringSubviewToFront(indicator)
        getData()
    }
    
    func getData() {
        print("start loading")
        self.indicator.startAnimating()
        let headers: HTTPHeaders = [
            "app-id": "5ff9e66763edb35e7de23e9b",
        ]
        AF.request("https://dummyapi.io/data/api/user?limit=10", headers: headers).responseJSON { response in
            //debugPrint(response)
            
            switch response.result {
            case .success(let data):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    let decoder = JSONDecoder()
                    let dummy_data = try decoder.decode(DummyData.self, from: jsonData)
                    self.person_data = dummy_data.data
                    self.personCollectionView.reloadData()
                    print("finish parsing")
                } catch {
                    debugPrint(error)
                }
            case .failure(let data):
                print("fail")
            default:
                return
            }
            self.indicator.stopAnimating()
        }
        print("finish loading")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = self.personCollectionView.indexPathsForSelectedItems?.first {
            let person_info = person_data[indexPath.row]
            if let vc = segue.destination as? DetailController {
                vc.user_id = person_info.id
            }
        }
        
    }
}

extension ViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return person_data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "personCell", for: indexPath) as! PersonCell
        let data = person_data[indexPath.row]
        
        if let url = data.picture {
            cell.profileImage.af.setImage(withURL: url)
        }
        cell.idLabel.text = data.id
        cell.nameLabel.text = data.firstName
        cell.emailLabel.text = data.email
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 5
        return cell
    }
    
    
}

extension ViewController:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.size.width-20) / 3
        let height = width*1.5
        return CGSize(width: width, height: height)
    }
}
