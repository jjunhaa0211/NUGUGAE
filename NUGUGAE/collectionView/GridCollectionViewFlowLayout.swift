//
//  FileGridCollectionViewFlowLayout.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/08/19.
//

import UIKit

class GridCollectionViewFlowLayout: UICollectionViewFlowLayout {
    var ratioHeightToWidth = 0.7
  var numberOfColumns = 1
  var cellSpacing = 0.0 {
    didSet {
      self.minimumLineSpacing = self.cellSpacing
      self.minimumInteritemSpacing = self.cellSpacing
    }
  }
  
  override init() {
    super.init()
      self.scrollDirection = .vertical
  }
  required init?(coder: NSCoder) {
    fatalError()
  }
}
