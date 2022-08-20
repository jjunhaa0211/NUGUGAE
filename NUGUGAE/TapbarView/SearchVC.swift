//
//  SearchVC.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/08/18.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
    var petList: [SearchPetList] = []
    
    var dataTasks = [URLSessionTask]()
    
    var currentPage = 1
    
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
      
//      fetchPet(of: )
      
      DogButton()
      CatButton()
      animalsButton()

  }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getPetList()
    }
    private func getPetList() {
        
        let url = "https://b6ce-222-118-155-166.jp.ngrok.io/api/pet/search?s=1&p=1"
        let AT : String? = KeyChain.read(key: Token.accessToken)
        let header : HTTPHeaders = [
            "Authorization" : "Bearer \(AT!)"
        ]
        
        print("")
        print("====================================")
        print("주 소 :: ", url)
        print("====================================")
        print("")
        
        AF.request(url, method: .get, encoding: URLEncoding.queryString, headers: header).validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let res):
                    
                    do {
                        let data = try JSONDecoder().decode([SearchPetList].self, from: response.data!)
                        print(data)
                        self.petList = data
                        print("⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️")
                        print("===petList는 data의 값을 보유 하고 있습니다===")
                        print("⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️")
                        self.collectionView.reloadData()
                    } catch {
                        print(error)
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
    self.petList.count
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCell.id, for: indexPath) as! MyCell
      
      let petListView = petList[indexPath.row]
      cell.configure(with: petListView)
      
    return cell
  }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let petListIndexPath = petList[indexPath.row]
        print(petListIndexPath)
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

private extension SearchViewController {
    func fetchPet(of imageIndexPath: PetList.Type) {
        guard let url = URL(string: "https://www.daejeon.go.kr/\(imageIndexPath)"),
            dataTasks.firstIndex(where: { $0.originalRequest?.url == url }) == nil else { return } //이미 Beer를 패칭했음. 그렇지 않다면,
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
            guard error == nil,
                  let self = self,
                  let response = response as? HTTPURLResponse,
                  let data = data,
                  let pets = try? JSONDecoder().decode([SearchPetList].self, from: data) else {
                    print("ERROR: URLSession data task error \(error?.localizedDescription ?? "")")
                    return
            }
            
            switch response.statusCode {
            case (200...299):
                self.petList += pets
                self.currentPage += 1

                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case (400...499):
                print(
                    """
                    ERROR: Client ERROR \(response.statusCode)
                    Response: \(response)
                    """
                )
            case (500...599):
                print(
                    """
                    ERROR: Server ERROR \(response.statusCode)
                    Response: \(response)
                    """
                )
            default:
                print(
                    """
                    ERROR: \(response.statusCode)
                    Response: \(response)
                    """
                )
            }
        }
        dataTask.resume()
        dataTasks.append(dataTask)
    }
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
