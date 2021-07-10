//
//  ViewController.swift
//  NaverWebtoonExample
//
//  Created by 송종근 on 2021/01/09.
//

import UIKit

class ViewController: UIViewController {
    
    var webtoonData = [
        WebToonData("참교육", "title_01", 4.9, "채용택 / 한가람"),
        WebToonData("독립일기", "title_02", 4.9, "자까"),
        WebToonData("더 복서", "title_03", 4.9, "정지훈"),
        WebToonData("열렙전사", "title_04", 4.9, "김세훈"),
        WebToonData("장씨세가 호위무사", "title_05", 4.9, "조형근 / 김인호"),
        WebToonData("1초", "title_06", 4.9, "시니 / 광운"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return webtoonData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "webToonCell", for: indexPath) as! WebToonCell
        // Todo : Title, 별점, 작가 명 채우기
        let data = webtoonData[indexPath.row%6]
        cell.titleLabel.text = data.title
        cell.ratingLabel.text = "\(data.rating!)"
        cell.authorLabel.text = data.author
        // 타이틀 이미지 변경
        cell.titleImage.image = UIImage(named: data.title_image)
        
        cell.layer.borderWidth = 0.3
        cell.layer.borderColor = UIColor.lightGray.cgColor
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        //let width = self.view.frame.size.width / 3
        let width = UIScreen.main.bounds.width / 3
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
}


