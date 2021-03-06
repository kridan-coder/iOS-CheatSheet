//
//  CollectionViewCell.swift
//  day10tvOS
//
//  Created by KriDan on 12.05.2021.
//

import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func setUpData(data: Data){
        let imageURL = data.image!

        image.kf.setImage(with: URL(string: imageURL))
        image.kf.indicatorType = .activity

        label.text = data.description
    }
    
}
