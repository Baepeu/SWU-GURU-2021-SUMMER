//
//  WebToonCell.swift
//  NaverWebtoonExample
//
//  Created by 송종근 on 2021/01/09.
//

import UIKit

// 어떤 클래스를 상속받는다. 라는 것은 이미 구현되어 있는 기능을 가져다 쓰겠다.
// 그 중에 일부만 커스터마이징을 해서 사용하겠다.
class WebToonCell:UICollectionViewCell {
    @IBOutlet weak var titleImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
  
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    
}
