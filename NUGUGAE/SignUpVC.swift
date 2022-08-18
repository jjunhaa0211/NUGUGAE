//
//  SignUpVC.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/08/18.
//

import UIKit
import Alamofire

class SignUpViewController : UIViewController {
    
    let nameField = UITextField()
    let idFidld = UITextField()
    let passworldField = UITextField()
    let emailField = UITextField()
    let emailCheckField = UITextField()
    let certificationButton = UIButton()

    var httpClient = HTTPClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        signUpText()
        nameViewLine()
        idViewLine()
        passworldViewLine()
        ageViewLine()
        NameAndIdAndPassAndAgeTextField()
        configureSignUpButton()
        certificationViewButton()
        emailCheckCodeViewLine()
        emailFieldView()
    }
    
    func signUpText() {
        let loginLabel = UILabel()
        loginLabel.textColor = .black
        loginLabel.text = "SignUp"
        view.addSubview(loginLabel)
        
        loginLabel.font = UIFont.boldSystemFont(ofSize: 35)
        
        loginLabel.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(200)
            $0.trailing.equalTo(-100)
            $0.bottom.equalTo(-700)
            $0.leading.equalTo(160)
            
        }
    }

    func nameViewLine() {
        let signUpLine = UIView()
        let ColorB = UIColor(named: "Color-b")
        view.addSubview(signUpLine)
        signUpLine.backgroundColor = ColorB
        signUpLine.layer.cornerRadius = 20
        signUpLine.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.top.equalTo(295)
            $0.leading.equalTo(45)
        }
    }

    func idViewLine() {
        let signUpLine = UIView()
        let ColorB = UIColor(named: "Color-b")
        view.addSubview(signUpLine)
        signUpLine.backgroundColor = ColorB
        signUpLine.layer.cornerRadius = 20
        signUpLine.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.top.equalTo(365)
            $0.leading.equalTo(45)
        }
    }

    func passworldViewLine() {
        let signUpLine = UIView()
        let ColorB = UIColor(named: "Color-b")
        view.addSubview(signUpLine)
        signUpLine.backgroundColor = ColorB
        signUpLine.layer.cornerRadius = 20
        signUpLine.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.top.equalTo(435)
            $0.leading.equalTo(45)
        }
    }
    
    func ageViewLine() {
        let signUpLine = UIView()
        let ColorB = UIColor(named: "Color-b")
        view.addSubview(signUpLine)
        signUpLine.backgroundColor = ColorB
        signUpLine.layer.cornerRadius = 20
        signUpLine.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-90)
            $0.top.equalTo(505)
            $0.leading.equalTo(45)
        }
    }
//    375 차이
    func certificationViewButton() {
        let ColorB = UIColor(named: "Color-b")
        view.addSubview(certificationButton)
        certificationButton.backgroundColor = ColorB
        certificationButton.layer.cornerRadius = 20
        certificationButton.setTitle("인증", for: .normal)
        certificationButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        certificationButton.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.width.equalTo(50)
            $0.trailing.equalTo(-45)
            $0.top.equalTo(505)
            $0.leading.equalTo(338)
        }
        certificationButton.addTarget(self, action: #selector(certificationAction), for: .touchUpInside)
    }
    @objc func certificationAction(sender: UIButton!){
        SendVerificationCodeButton()
        print("인증 버튼")
    }
    
    func emailCheckCodeViewLine() {
        let emailCheckCode = UIView()
        let ColorB = UIColor(named: "Color-b")
        view.addSubview(emailCheckCode)
        emailCheckCode.backgroundColor = ColorB
        emailCheckCode.layer.cornerRadius = 20
        emailCheckCode.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.top.equalTo(575)
            $0.leading.equalTo(45)
        }
    }
    
    func NameAndIdAndPassAndAgeTextField() {
        
        nameField.borderStyle = .none
        view.addSubview(nameField)
        nameField.attributedPlaceholder = NSAttributedString(string: "please write name...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        nameField.textColor = .black
        nameField.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.top.equalTo(295)
            $0.leading.equalTo(65)
        }
        
        idFidld.borderStyle = .none
        view.addSubview(idFidld)
        idFidld.attributedPlaceholder = NSAttributedString(string: "please write id...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        idFidld.textColor = .black
        idFidld.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.top.equalTo(365)
            $0.leading.equalTo(65)
        }
        
        passworldField.borderStyle = .none
        passworldField.attributedPlaceholder = NSAttributedString(string: "please write password...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passworldField.textColor = .black
        passworldField.isSecureTextEntry = true
        view.addSubview(passworldField)
        passworldField.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.top.equalTo(435)
            $0.leading.equalTo(65)
        }
        
        emailField.borderStyle = .none
        view.addSubview(emailField)
        emailField.attributedPlaceholder = NSAttributedString(string: "please write your email...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        emailField.textColor = .black
        emailField.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.top.equalTo(505)
            $0.leading.equalTo(65)
        }
        
    }
    func emailFieldView() {
        emailCheckField.borderStyle = .none
        view.addSubview(emailCheckField)
        emailCheckField.attributedPlaceholder = NSAttributedString(string: "please write your emailCheck Code...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        emailCheckField.textColor = .red
        emailCheckField.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.top.equalTo(575)
            $0.leading.equalTo(65)
        }

    }
    
    func configureSignUpButton() {
        let SignUpButton = UIButton()
        let ColorC = UIColor(named: "Color-c")
        SignUpButton.setTitle("Sign in", for: .normal)
        SignUpButton.backgroundColor = ColorC
        SignUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(SignUpButton)
        
        SignUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        SignUpButton.layer.cornerRadius = 10
        
        SignUpButton.snp.makeConstraints{
            $0.height.equalTo(55)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.bottom.equalTo(-160)
            $0.leading.equalTo(45)
        }
        
        SignUpButton.addTarget(self, action: #selector(SignUpbuttonAction), for: .touchUpInside)
        
        }
    
    @objc func SignUpbuttonAction(sender: UIButton!){
        postsignUp()
//        print("------------------------------")
//        print("Name : \(nameField.text!)")
//        print("Id : \(idFidld.text!)")
//        print("Password : \(passworldField.text!)")
//        print("Age : \(emailField.text!)")
//        print("------------------------------")

    }
    func postsignUp() {
            let url = "https://b6ce-222-118-155-166.jp.ngrok.io/api/auth/signup"
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.timeoutInterval = 10

            // POST 로 보낼 정보
        let params = ["name": nameField.text!,
                      "email":emailField.text!,
                      "emailCheckCode":emailCheckField.text!,
                      "pw":passworldField.text!,
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
                    }
                        print("로그인 성공😁")
                    print("url 경로 : \(request.url as Any)")
                    print("✅POST 성공✅")
                        let goToMainTabBarVC = FirstViewController()
                        goToMainTabBarVC.modalPresentationStyle = .fullScreen
                        self.present(goToMainTabBarVC, animated: true, completion: nil)
                    print("이동 성공 🙃")
                case .failure(let error):
                    print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                }
            }
    }
    func SendVerificationCodeButton() {
        let url = "https://b6ce-222-118-155-166.jp.ngrok.io/api/auth\(AuthAPI.emailcheck.path() + "?email="+emailField.text!)"
//        let url = "https://b6ce-222-118-155-166.jp.ngrok.io/api/auth/email?email=jnxhx06@gmail.com"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
//            params: nil,
//            header:Header.tokenIsEmpty.header()
        AF.request(url,method: .post,encoding: JSONEncoding.default).responseString { (response) in
            switch response.response?.statusCode {
            case 200:
                print("인증번호 확인")
            default:
                print("hi error 🚫")
                print(response.response?.statusCode ?? 0)
                print(url)
                
            }
        }
    }

}


//view미리보기
import SwiftUI

struct SignUpViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SignUpViewController {
        return SignUpViewController()
    }
    
    func updateUIViewController(_ uiViewController: SignUpViewController, context: Context) { }
    
    
    typealias UIViewControllerType = SignUpViewController
}

@available(iOS 13.0.0, *)
struct SignUpViewPreview: PreviewProvider {
    static var previews: some View {
        SignUpViewControllerRepresentable()
    }
}
