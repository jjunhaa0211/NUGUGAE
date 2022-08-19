//
//  SearchVC.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/08/18.
//

import UIKit

class SearchViewController: UIViewController {
    
    let dogButton = UIButton()
    let catButton  = UIButton()
    let animalButton = UIButton()
    
    let ColorC = UIColor(named: "Color-c")
    let ColorA = UIColor(named: "Color-a")
    let dog : String = "DognotFound"
    let cat : String = "CatNotFound"
    let animal : String = "AnimalNotFound"
    
    private var dataSource = getSampleImages()

    
  private let gridFlowLayout: GridCollectionViewFlowLayout = {
    let layout = GridCollectionViewFlowLayout()
    layout.cellSpacing = 8
    layout.numberOfColumns = 2
    return layout
  }()
  
  private lazy var collectionView: UICollectionView = {
    let view = UICollectionView(frame: .zero, collectionViewLayout: self.gridFlowLayout)
    view.isScrollEnabled = true
    view.showsHorizontalScrollIndicator = false
    view.showsVerticalScrollIndicator = true
    view.contentInset = .zero
    view.backgroundColor = .clear
    view.clipsToBounds = true
    view.register(MyCell.self, forCellWithReuseIdentifier: "MyCell")
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
      
      view.backgroundColor = ColorC
    
    self.view.addSubview(self.collectionView)

    NSLayoutConstraint.activate([
      self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
      self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
      self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120),
      self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
    ])
    
    self.collectionView.dataSource = self
    self.collectionView.delegate = self
      
      DogButton()
      CatButton()
      animalsButton()
  }
    
    func CatButton() {
        catButton.setTitle("Cat", for: .normal)
        catButton.setTitleColor(ColorC, for: .normal)
        catButton.backgroundColor = ColorA
        catButton.layer.cornerRadius = 10
        
        view.addSubview(catButton)
        
        catButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        catButton.snp.makeConstraints{
            $0.height.equalTo(55)
            $0.width.equalTo(105)
            $0.trailing.equalTo(0)
            $0.top.equalTo(60)
            $0.leading.equalTo(280)
        }
        
        catButton.addTarget(self, action: #selector(CatbuttonAction), for: .touchUpInside)
        
    }
    
    @objc func CatbuttonAction(sender: UIButton!){
        print("고양이 버튼 실행됨")
        func getSampleImages() -> [UIImage?] {
          (1...100).map { _ in return UIImage(named: cat) }
        }
    }
    func DogButton() {
        dogButton.setTitle("Dog", for: .normal)
        dogButton.setTitleColor(ColorC, for: .normal)
        dogButton.backgroundColor = ColorA
        dogButton.layer.cornerRadius = 10
        
        view.addSubview(dogButton)
        
        dogButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        dogButton.snp.makeConstraints{
            $0.height.equalTo(55)
            $0.width.equalTo(105)
            $0.trailing.equalTo(-280)
            $0.top.equalTo(60)
            $0.leading.equalTo(0)
        }
        
        dogButton.addTarget(self, action: #selector(DogbuttonAction), for: .touchUpInside)
        
        }
    
    @objc func DogbuttonAction(sender: UIButton!){
        print("강아지 버튼 실행됨")
        func getSampleImages() -> [UIImage?] {
          (1...100).map { _ in return UIImage(named: dog) }
        }
    }
    func animalsButton() {
        animalButton.setTitle("animal", for: .normal)
        animalButton.setTitleColor(ColorC, for: .normal)
        animalButton.backgroundColor = ColorA
        animalButton.layer.cornerRadius = 10
        
        view.addSubview(animalButton)
        
        animalButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        animalButton.snp.makeConstraints{
            $0.height.equalTo(55)
            $0.width.equalTo(105)
            $0.trailing.equalTo(-150)
            $0.top.equalTo(60)
            $0.leading.equalTo(150)
        }
        
        animalButton.addTarget(self, action: #selector(animalbuttonAction), for: .touchUpInside)
        
        }
    
    @objc func animalbuttonAction(sender: UIButton!){
        print("동물 버튼 실행됨")
    }
}

extension SearchViewController: UICollectionViewDataSource,UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    self.dataSource.count
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCell.id, for: indexPath) as! MyCell
    cell.prepare(image: self.dataSource[indexPath.item])
    return cell
  }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dateIndexPath = dataSource[indexPath.row]
        print(dateIndexPath!)
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    guard
      let flowLayout = collectionViewLayout as? GridCollectionViewFlowLayout,
      flowLayout.numberOfColumns > 0
    else { fatalError() }
    
    let widthOfCells = collectionView.bounds.width - (collectionView.contentInset.left + collectionView.contentInset.right)
    let widthOfSpacing = CGFloat(flowLayout.numberOfColumns - 1) * flowLayout.cellSpacing
    let width = (widthOfCells - widthOfSpacing) / CGFloat(flowLayout.numberOfColumns)

    return CGSize(width: width, height: width * flowLayout.ratioHeightToWidth)
  }
}

func getSampleImages() -> [UIImage?] {
  (1...100).map { _ in return UIImage(named: "AnimalNotFound") }
}

import SwiftUI

struct PeedViewControllerRepresentable: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = SearchViewController

    func makeUIViewController(context: Context) -> SearchViewController {
        return SearchViewController()
    }
    
    func updateUIViewController(_ uiViewController: SearchViewController, context: Context) { }
}

@available(iOS 13.0.0, *)
struct PeedViewPreview: PreviewProvider {
    static var previews: some View {
        PeedViewControllerRepresentable()
    }
}
