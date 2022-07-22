//
//  signUp.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/06/27.
//

import UIKit
import Alamofire

class signUp: UIViewController {

    @IBOutlet var userName: UITextField!
    
    @IBOutlet var userPasssword: UITextField!
    
    @IBOutlet var signUpButton: UIButton!
    
    @IBOutlet weak var userEmail: UITextField!
    
    @IBOutlet weak var emailCheckCode: UITextField!
    
    @IBOutlet weak var SendVerificationCode: UIButton!
    
    var httpClient = HTTPClient()
    
    var radius = 19
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad - signUpVC")
        SendVerificationCode.titleLabel?.text = "인증번호 받기"
        // Do any additional setup after loading the view.
        userName.layer.cornerRadius = CGFloat(radius)
        userPasssword.layer.cornerRadius =
        CGFloat(radius)
        signUpButton.layer.cornerRadius =
        CGFloat(radius)
    }
    func postsignUp() {
            let url = "http://192.168.0.29:8080/api/auth/signup"
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.timeoutInterval = 10

            // POST 로 보낼 정보
        let params = ["name": userName.text!,
                      "email":userEmail.text!,
                      "emailCheckCode":emailCheckCode.text!,
                      "pw":userPasssword.text!,
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
                    debugPrint(response)
                    if let userDate = try? JSONDecoder().decode(TokenModel.self, from: response.data!) {
                        KeyChain.create(key: Token.accessToken, token: userDate.access_token)
                        KeyChain.create(key: Token.refreshToken, token: userDate.resfresh_token)
                        print("로그인 성공😁")
                        if let removable = self.view.viewWithTag(102) {
                            removable.removeFromSuperview()
                            self.performSegue(withIdentifier: "goToSuccessVC", sender: self)
                        }
                    } else { print("이동 성공") }
                    
                    print("url 경로 : \(request.url as Any)")
                    print("✅POST 성공✅")
                case .failure(let error):
                    print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                }
            }
        }
//    func signup(email: String, password: String, nickName: String,emailCheckCode: String,userType: String) {
//        httpClient.post(
//            url: AuthAPI.signup.path(),
//            params: ["email": email, "emailCheckCode": emailCheckCode, "pw": password, "name": nickName, "userType": userType],
//            header: Header.tokenIsEmpty.header()
//        ).responseData(completionHandler: { res in
//            switch res.response?.statusCode {
//            case 200:
//                self.navigationController?.popViewController(animated: true)
//            default:
//                print(res.response?.statusCode ?? 0)
//            }
//        })
//    }
//
    @IBAction func SendVerificationCodeButton(_ sender: UIButton) {
        httpClient.post(
            url: AuthAPI.emailcheck.path() + "?email="+userEmail.text!,
            params: nil,
            header:Header.tokenIsEmpty.header()
        ).responseData(completionHandler: {res in
            switch res.response?.statusCode {
            case 200:
                sender.titleLabel?.text! = "인증번호 확인"
            default:
                print(res.response?.statusCode ?? 0)
            }
        })
    }
    @IBAction func signInPressButton(_ sender: UIButton) {
        postsignUp()
        if(userName.text == "") {
            let checkAgainAction = UIAlertController(title: "아이디를 확인해주세요", message: "다시 입력해주세요.", preferredStyle: .alert)
            checkAgainAction.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(checkAgainAction, animated: true, completion: nil)
        };if(userEmail.text == "") {
            let checkAgainAction = UIAlertController(title: "email를 확인해주세요", message: "다시 입력해주세요.", preferredStyle: .alert)
            checkAgainAction.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(checkAgainAction, animated: true, completion: nil)
        };if(emailCheckCode.text == "") {
            let checkAgainAction = UIAlertController(title: "전송된 코드를 입력해주세요.", message: "다시 입력해주세요.", preferredStyle: .alert)
            checkAgainAction.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(checkAgainAction, animated: true, completion: nil)
        };if(userPasssword.text == "") {
            let checkAgainAction = UIAlertController(title: "패스워드를 확인해주세요", message: "다시 입력해주세요.", preferredStyle: .alert)
            checkAgainAction.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(checkAgainAction, animated: true, completion: nil)
        };
    }
}
