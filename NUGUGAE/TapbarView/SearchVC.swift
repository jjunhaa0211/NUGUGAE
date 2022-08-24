//
//  SearchVC.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/08/18.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
    var petList: PetPosts = PetPosts(searchPetList: [])
    
    let dogButton = UIButton()
    let catButton  = UIButton()
    let animalButton = UIButton()
    
    let ColorC = UIColor(named: "Color-c")
    let ColorA = UIColor(named: "Color-a")
    let dog : String = "DognotFound"
    let cat : String = "CatNotFound"
    let animal : String = "AnimalNotFound"

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
      
      view.backgroundColor = ColorA
    
    self.view.addSubview(self.collectionView)

    NSLayoutConstraint.activate([
      self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
      self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
      self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120),
      self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
    ])
    
    self.collectionView.dataSource = self
    self.collectionView.delegate = self
      
//      fetchPet(of: )
      
      DogButton()
      CatButton()
      animalsButton()

  }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getDogPetList()
    }
    private func getDogPetList() {
        
        let url = "http://10.156.147.167:8080/api/pet/search?s=1&p=1"
        let AT : String? = KeyChain.read(key: Token.accessToken)
        let header : HTTPHeaders = [
            "Authorization" : "Bearer \(AT!)"
        ]
        
        print("====================================")
        print("주 소 :: ", url)
        print("====================================")
        
        AF.request(url, method: .get, encoding: URLEncoding.queryString, headers: header).validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let res):
                    do {
                        let data = try JSONDecoder().decode(PetPosts.self, from: response.data!)
                        print(data)
                        self.petList = data
                        print("⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️")
                        print("===petList는 data의 값을 보유 하고 있습니다===")
                        print("⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️")
                        self.collectionView.reloadData()
                    } catch {
                        print("ㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗ")
                        print(error)
                        //debugPrint(response)
                        print("ㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗ")
                    }
                    
                    print("")
                    print("-------------------------------")
                    print("응답 코드 :: ", response.response?.statusCode ?? 0)
                    print("-------------------------------")
                    print("응답 데이터 :: ", String(data: res, encoding: .utf8) ?? "")
                    print("-------------------------------")
                    print("")
                    
                case .failure(let err):
                    print("")
                    print("-------------------------------")
                    print("응답 코드 :: ", response.response?.statusCode ?? 0)
                    print("-------------------------------")
                    print("에 러 :: ", err.localizedDescription)
                    print("====================================")
                    debugPrint(response)
                    print("")
                    break
                }
            }
    }
    private func getCatPetList() {
        
        let url = "http://10.156.147.167:8080/api/pet/search?s=2&p=1"
        let AT : String? = KeyChain.read(key: Token.accessToken)
        let header : HTTPHeaders = [
            "Authorization" : "Bearer \(AT!)"
        ]
        
        print("====================================")
        print("주 소 :: ", url)
        print("====================================")
        
        AF.request(url, method: .get, encoding: URLEncoding.queryString, headers: header).validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let res):
                    do {
                        let data = try JSONDecoder().decode(PetPosts.self, from: response.data!)
                        print(data)
                        self.petList = data
                        print("⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️")
                        print("===petList는 data의 값을 보유 하고 있습니다===")
                        print("⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️")
                        self.collectionView.reloadData()
                    } catch {
                        print("ㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗ")
                        print(error)
                        //debugPrint(response)
                        print("ㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗ")
                    }
                    
                    print("")
                    print("-------------------------------")
                    print("응답 코드 :: ", response.response?.statusCode ?? 0)
                    print("-------------------------------")
                    print("응답 데이터 :: ", String(data: res, encoding: .utf8) ?? "")
                    print("-------------------------------")
                    print("")
                    
                case .failure(let err):
                    print("")
                    print("-------------------------------")
                    print("응답 코드 :: ", response.response?.statusCode ?? 0)
                    print("-------------------------------")
                    print("에 러 :: ", err.localizedDescription)
                    print("====================================")
                    debugPrint(response)
                    print("")
                    break
                }
            }
    }
    
    private func getAnyPetList() {
        
        let url = "http://10.156.147.167:8080/api/pet/search?s=3&p=1"
        let AT : String? = KeyChain.read(key: Token.accessToken)
        let header : HTTPHeaders = [
            "Authorization" : "Bearer \(AT!)"
        ]
        
        print("====================================")
        print("주 소 :: ", url)
        print("====================================")
        
        AF.request(url, method: .get, encoding: URLEncoding.queryString, headers: header).validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let res):
                    do {
                        let data = try JSONDecoder().decode(PetPosts.self, from: response.data!)
                        print(data)
                        self.petList = data
                        print("⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️")
                        print("===petList는 data의 값을 보유 하고 있습니다===")
                        print("⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️")
                        self.collectionView.reloadData()
                    } catch {
                        print("ㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗ")
                        print(error)
                        //debugPrint(response)
                        print("ㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗ")
                    }
                    
                    print("")
                    print("-------------------------------")
                    print("응답 코드 :: ", response.response?.statusCode ?? 0)
                    print("-------------------------------")
                    print("응답 데이터 :: ", String(data: res, encoding: .utf8) ?? "")
                    print("-------------------------------")
                    print("")
                    
                case .failure(let err):
                    print("")
                    print("-------------------------------")
                    print("응답 코드 :: ", response.response?.statusCode ?? 0)
                    print("-------------------------------")
                    print("에 러 :: ", err.localizedDescription)
                    print("====================================")
                    debugPrint(response)
                    print("")
                    break
                }
            }
    }

    
    func CatButton() {
        catButton.setTitle("Cat", for: .normal)
        catButton.setTitleColor(.white, for: .normal)
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
        getCatPetList()
    }
    func DogButton() {
        dogButton.setTitle("Dog", for: .normal)
        dogButton.setTitleColor(.white, for: .normal)
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
        getDogPetList()
    }

    func animalsButton() {
        animalButton.setTitle("animal", for: .normal)
        animalButton.setTitleColor(.white, for: .normal)
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
        getAnyPetList()

    }

}

extension SearchViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return petList.searchPetList.count
  }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCell.id, for: indexPath) as! MyCell
      let petListView = petList.searchPetList[indexPath.row]
      
      cell.configure(with: petListView)
      
    return cell
  }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let petListIndexPath = petList.searchPetList[indexPath.row]
        let detailViewController = PetDetailViewController()
        detailViewController.pets = petListIndexPath
        self.show(detailViewController, sender: nil)
        print(petListIndexPath)
    }
}



extension SearchViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    guard let flowLayout = collectionViewLayout as? GridCollectionViewFlowLayout,
      flowLayout.numberOfColumns > 0
    else { fatalError() }

    let widthOfCells = collectionView.bounds.width - (collectionView.contentInset.left + collectionView.contentInset.right)
      
      //가운데 뛰는 만큼
      let widthOfSpacing = CGFloat(flowLayout.numberOfColumns) * flowLayout.cellSpacing
    let width = (widthOfCells - widthOfSpacing) / CGFloat(flowLayout.numberOfColumns)
      
      return CGSize(width: width, height: width * flowLayout.ratioHeightToWidth)
//      return CGSize(width: view.frame.width, height: 150)
  }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
