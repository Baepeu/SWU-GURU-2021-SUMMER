//
//  BannerViewController.swift
//  NaverWebtoonExample
//
//  Created by 송종근 on 2021/01/10.
//

import UIKit

class BannerViewController:UIViewController {
    let banner_images = ["banner_01", "banner_02", "banner_03", "banner_04"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 화면 너비 : 높이 = 218:120  -> 너비*120 = 높이*218 -> 높이 = 너비 * 120/218
        let screenSize = UIScreen.main.bounds // 화면의 정보
        let width = screenSize.width
        let height = width * 120 / 218
        
        for (index, imageName) in banner_images.enumerated() {
            let image = UIImage(named: imageName)
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: CGFloat(index)*width, y: 0, width: width, height: height)
            self.view.addSubview(imageView)
        }
        
        
        self.view.frame = CGRect(x: 0, y: 0, width: width*CGFloat(banner_images.count), height: height)
    }
    
}
