//
//  MyCell.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/08/19.
//
import UIKit
import Kingfisher

final class MyCell: UICollectionViewCell {
  static let id = "MyCell"
  
  // MARK: UI
  private let imageView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFill
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  // MARK: Initializer
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.contentView.addSubview(self.imageView)
    NSLayoutConstraint.activate([
      self.imageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
      self.imageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
      self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
      self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
    ])
  }
    func configure(with pet: SearchPetList) {
        let imageURL = URL(string: pet.filePath ?? "")
        imageView.kf.setImage(with: imageURL, placeholder: #imageLiteral(resourceName: "DognotFound"))
    }
}
