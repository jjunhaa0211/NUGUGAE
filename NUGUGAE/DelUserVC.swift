//
//  DelUserVC.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/07/22.
//

import UIKit
import Alamofire

class DelUserVC : UIViewController {
    
    @IBOutlet var emailName: UITextField!
    @IBOutlet var userPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func DeleteUser() {
            let url = "https://967d-222-118-155-166.jp.ngrok.io/api/auth/delete"
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "DELETE"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.timeoutInterval = 10
        // POST 로 보낼 정보
        let params = ["email" : emailName.text,
                      "pw" : userPassword.text] as Dictionary
            // httpBody 에 parameters 추가
            do {
                try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
            } catch {
                print("http Body Error")
            }

            AF.request(request).responseString { (response) in
                switch response.result {
                case .success:
                    debugPrint(response)
                        KeyChain.delete(key: Token.accessToken)
                        print("삭제 성공😁")
                        if let removable = self.view.viewWithTag(102) {
                            removable.removeFromSuperview()
                            self.performSegue(withIdentifier: "goToMainVC", sender: self)
                        }
                    print("url 경로 : \(request.url as Any)")
                    print("✅POST 성공✅")
                case .failure(let error):
                    print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                }
            }
        }

    @IBAction func outUserButton(_ sender: Any) {
        DeleteUser()
    }
    
}
