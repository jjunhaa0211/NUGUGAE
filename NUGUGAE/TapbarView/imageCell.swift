//
//  imageCell.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/08/18.
//

import UIKit
import SnapKit
import Kingfisher

class ImageCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleToFill
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(with petImage: SearchPetList) {
        let imageURL = URL(string: petImage.filePath ?? "")
        imageView.kf.setImage(with: imageURL, placeholder: #imageLiteral(resourceName: "notFound"))
    }
    
}
