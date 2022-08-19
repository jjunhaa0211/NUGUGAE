//
//  HomeVC.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/08/18.
//

import UIKit
import SnapKit
import Then
import Alamofire

class HomeViewController : UIViewController {
    
    var petList: [SearchPetList] = []
    
    private func getMyToDoList() {
            
        let url = "https://b6ce-222-118-155-166.jp.ngrok.io/api/pet/search?s={1}&p={0}"
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
