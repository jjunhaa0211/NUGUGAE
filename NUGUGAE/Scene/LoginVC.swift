//
//  Login.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/06/27.
//

import UIKit
import Alamofire

class loginVC: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad - LoginVC")
        signInBtn.layer.cornerRadius = CGFloat(19)
    }
    func postLogin() {
            let url = "https://967d-222-118-155-166.jp.ngrok.io/api/auth/login"
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.timeoutInterval = 10

            // POST 로 보낼 정보
        let params = ["email":userName.text!,
                      "pw":password.text! ] as Dictionary

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
                    if let userDate = try? JSONDecoder().decode(TokenModel.self, from: response.data!) {
                        KeyChain.create(key: Token.accessToken, token: userDate.access_token)
                        KeyChain.create(key: Token.refreshToken, token: userDate.resfresh_token)
                        print("로그인 성공😁")
                        if let removable = self.view.viewWithTag(102) {
                            removable.removeFromSuperview()
                            self.performSegue(withIdentifier: "goToSuccessVC", sender: self)
                        }
                    } else { print("🌄 화면 전환 성공") }
                    print("🤑POST 성공")
                case .failure(let error):
                    if response.response?.statusCode != 200 {
                        print("로그인 실패")
                        let loginFailLabel = UILabel(frame: CGRect(x: 95, y: 479, width: 279, height: 45))
                        loginFailLabel.text = "아이디나 비밀번호가 다릅니다."
                        loginFailLabel.textColor = UIColor.red
                        loginFailLabel.tag = 102
                        self.view.addSubview(loginFailLabel)
                        print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                }
            }
        }
    }
    @IBAction func LoginButton(_ sender: Any) {
        postLogin()
        if(userName.text == "" && password.text == ""){
            let checkAgainAction = UIAlertController(title: "입력을 하나도 안했네요 ^^", message: "다시 확인해주세요", preferredStyle: .alert)
            checkAgainAction.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(checkAgainAction, animated: true, completion: nil)
        };
        if(userName.text == "") {
            let checkAgainAction = UIAlertController(title: "아이디를 확인해주세요", message: "다시 입력해주세요.", preferredStyle: .alert)
            checkAgainAction.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(checkAgainAction, animated: true, completion: nil)
        };if(password.text == "") {
            let checkAgainAction = UIAlertController(title: "password를 확인해주세요", message: "다시 입력해주세요.", preferredStyle: .alert)
            checkAgainAction.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(checkAgainAction, animated: true, completion: nil)
        };
  ////로그인 정보가 맞을때만 작동하는 거 만들기
//------------------------------------------------------
        
//        if(userName.text != "" && password.text != ""){
//            let checkAgainAction = UIAlertController(title: "gmail과 password를 확인해주세요", message: "다시 확인해주세요", preferredStyle: .alert)
//            checkAgainAction.addAction(UIAlertAction(title: "Okay", style: .default))
//            self.present(checkAgainAction, animated: true, completion: nil)
//        };
//        if(userName.text != "") {
//            let checkAgainAction = UIAlertController(title: "gmail를 확인해주세요", message: "gamil가 틀렸습니다.", preferredStyle: .alert)
//            checkAgainAction.addAction(UIAlertAction(title: "Okay", style: .default))
//            self.present(checkAgainAction, animated: true, completion: nil)
//        };if(password.text != "") {
//            let checkAgainAction = UIAlertController(title: "비밀번호를 확인해주세요", message: "비밀번호를 다시 입력해주세요.", preferredStyle: .alert)
//            checkAgainAction.addAction(UIAlertAction(title: "Okay", style: .default))
//            self.present(checkAgainAction, animated: true, completion: nil)
//        };
//    }
// ------------------------------------------------------
    }
}
