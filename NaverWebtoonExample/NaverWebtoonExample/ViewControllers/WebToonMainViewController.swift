//
//  BannerViewController.swift
//  NaverWebtoonExample
//
//  Created by 송종근 on 2021/01/10.
//

import UIKit

class WebToonMainViewController:UIViewController {
    
    @IBOutlet weak var bannerScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bannerViewController = BannerViewController()
        // 화면에 표시되도록 넣어주기
        bannerScrollView.addSubview(bannerViewController.view)
        // 스크롤이 가능하도록 컨텐츠 사이즈 설정
        bannerScrollView.contentSize = bannerViewController.view.frame.size
        
    }
}
