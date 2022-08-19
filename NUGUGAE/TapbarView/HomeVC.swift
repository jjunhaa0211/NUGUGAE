//
//  HomeVC.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/08/18.
//

import UIKit
import Alamofire
import SwiftUI

class HomeViewController : UICollectionViewController {
    
    var petList : [SearchPetList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.hidesBarsOnSwipe = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "NUGUGAELogo"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "person.crop.circle"), style: .plain, target: nil, action: nil)
        
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCollectionViewCell")
        collectionView.register(HomeCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HomeCollectionViewHeader")
        getMySearchPetList()
    }
    private func getMySearchPetList() {
        
        let url = "https://b6ce-222-118-155-166.jp.ngrok.io/api/pet/search?s={1}&p={1}"
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
                    } catch {
                        print(error)
                    }
                    
                    print("")
                    print("-------------------------------")
                    print("응답 코드 :: ", response.response?.statusCode ?? 0)
                    print("-------------------------------")
                    print("응답 데이터 :: ", String(data: res, encoding: .utf8) ?? "")
                    print("====================================")
                    debugPrint(response)
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

extension HomeViewController {
    //섹션당 보여질 셀의 계수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //예)content의 item 개수 만큼(return contents[section].contentItem.count
        switch section {
        default:
            return petList[section].filePath.count
        }
    }
    
    //콜렉션뷰 셀 설정
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
////
////        //image가 string 값으로 옴
////        cell.imageView.image = petList[indexPath.section].filePath[indexPath.row]
////        return cell
//        return 1
//    }
    
    //header 설정
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HomeCollectionViewHeader", for: indexPath) as? HomeCollectionViewHeader else { fatalError("could not dequeue header")}
            headerView.sectionNameLabel.text = "안녕"
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
    
    //섹션 개수 설정
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return petList.count
    }
    
    //셀 선텍시 이벤트
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let sctionName = petList[indexPath.row].filePath
//        print("사진 이름 : \(sctionName)")
//    }
    
}

struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container : UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            let layout = UICollectionViewLayout()
            let homeViewController = HomeViewController(collectionViewLayout: layout)
            return UINavigationController(rootViewController: homeViewController)
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
        
        typealias UIViewControllerType = UIViewController
    }
}
