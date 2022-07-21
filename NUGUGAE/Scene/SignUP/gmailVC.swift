//
//  gmailVC.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/07/05.
//

import UIKit
import Alamofire

class gmailVC: UIViewController {

func postsignUp() {
        let url = "http://192.168.137.232:9090/api/auth/signup"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10

        // POST 로 보낼 정보
    let params = ["name": userName.text!,"email":userEmail.text!,               "emailCheckCode":emailCheckCode.text!,"pw":userPasssword.text!,
                  "userType": "USER"
                 ] as Dictionary

        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }

        AF.request(request).responseString { (response) in
            switch response.result {
            case .success:
                print("url 경로 : \(request.url as Any)")
                print("✅POST 성공✅")
            case .failure(let error):
                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
    }
}
