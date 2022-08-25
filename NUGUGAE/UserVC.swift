//
//  HomeVC.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/08/18.
//

import UIKit
import SnapKit
import Alamofire

class UserViewController : UIViewController {
    
    var showList: ShowMyPet = ShowMyPet(pets: [])

    let ColorC = UIColor(named: "Color-c")
    let ColorA = UIColor(named: "Color-a")
    let ColorB = UIColor(named: "Color-b")
    let ColorD = UIColor(named: "Color-d")
    
    let refresh = UIRefreshControl()
    
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
      view.register(UserCell.self, forCellWithReuseIdentifier: "UserCell")
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    func userPetLabel() {
        let textLabel = UILabel()
        
        view.addSubview(textLabel)
        textLabel.text = "Add Pet List"
        
        textLabel.textColor = .white
        
        textLabel.font = UIFont.boldSystemFont(ofSize: 50)
        
        textLabel.snp.makeConstraints{
            $0.height.equalTo(160)
            $0.width.equalTo(200)
            $0.trailing.equalTo(-10)
            $0.top.equalTo(10)
            $0.leading.equalTo(10)
        }
    }
    func userPetView() {
        let petView = UILabel()
        
        view.addSubview(petView)
        
        petView.backgroundColor = ColorA
        
        petView.snp.makeConstraints{
            $0.height.equalTo(120)
            $0.width.equalTo(220)
            $0.trailing.equalTo(0)
            $0.top.equalTo(0)
            $0.leading.equalTo(0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initRefresh()
        
        view.backgroundColor = .white
        
        self.view.addSubview(self.collectionView)
        
        NSLayoutConstraint.activate([
          self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
          self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
          self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120),
          self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        showPetList()
        
        userPetView()
        
        userPetLabel()
    }
    
    private func showPetList() {
        
        let url = "http://10.156.147.167:8080/api/pet/showMyPet"
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
                        let data = try JSONDecoder().decode(ShowMyPet.self, from: response.data!)
                        print(data)
                        self.showList = data
                        print("🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎")
                        print("===showPet는 data의 값을 보유 하고 있습니다===")
                        print("🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎")
                        self.collectionView.reloadData()
                    } catch {
                        print("🤬🤬🤬🤬🤬🤬🤬")
                        print(error)
                        print("🥵🥵🥵🥵🥵🥵🥵")
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
}


extension UserViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return showList.pets.count
  }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCell.id, for: indexPath) as! UserCell
        let petListView = showList.pets[indexPath.row]
        
        cell.configure(with: petListView)
      
    return cell
  }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let petListIndexPath = showList.pets[indexPath.row]
        let showDetailViewController = ShowPetDetailViewController()
        showDetailViewController.pets = petListIndexPath
        self.show(showDetailViewController, sender: nil)
        print(petListIndexPath)
    }
}




extension UserViewController: UICollectionViewDelegateFlowLayout {
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

//새로 고침
extension UserViewController {
    
    func initRefresh() {
        refresh.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        refresh.backgroundColor = UIColor.clear
        self.collectionView.refreshControl = refresh
    }
 
    @objc func refreshTable(refresh: UIRefreshControl) {
        print("새로고침")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.collectionView.reloadData()
            self.showPetList()
            refresh.endRefreshing()
        }
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(velocity.y < -0.1) {
            self.refreshTable(refresh: self.refresh)
        }
    }
 
}
