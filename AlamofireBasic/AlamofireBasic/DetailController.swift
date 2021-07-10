//
//  DetailController.swift
//  AlamofireBasic
//
//  Created by 송종근 on 2021/01/10.
//

import UIKit

import Alamofire
import AlamofireImage
import NVActivityIndicatorView

class DetailController:UIViewController {
    var user_id:String!
    var user_info:PersonDetail!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var registerdateLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    var indicator:NVActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), type: .ballZigZag, color: .white, padding: self.view.frame.width/2 - 40)
        indicator.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.view.addSubview(indicator)
        self.view.bringSubviewToFront(indicator)
        
        getData(user_id)
    }
    
    func getData(_ user_id:String) {
        print("start loading")
        self.indicator.startAnimating()
        let headers: HTTPHeaders = [
            "app-id": "5ff9e66763edb35e7de23e9b",
        ]
        AF.request("https://dummyapi.io/data/api/user/\(user_id)", headers: headers).responseJSON { response in
            //debugPrint(response)
            
            switch response.result {
            case .success(let data):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    
                    let decoder = JSONDecoder()
                    self.user_info = try decoder.decode(PersonDetail.self, from: jsonData)
                    self.updateInfo()
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
    
    func updateInfo() {
        print("update info",user_info)
        
        idLabel.text = user_info.id
        nameLabel.text = "\(user_info.title) \(user_info.firstName) \(user_info.lastName)"
        genderLabel.text = user_info.gender
        birthdayLabel.text = user_info.dateOfBirth
        registerdateLabel.text = user_info.registerDate
        emailLabel.text = user_info.email
        phoneLabel.text = user_info.phone
        if let address = user_info.location {
            addressLabel.text = "\(address.street), \(address.city), \(address.state), \(address.country)"
        }
        
        profileImage.af.setImage(withURL: user_info.picture)
        
    }
}
