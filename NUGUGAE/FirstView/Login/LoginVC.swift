//
//  LoginVC.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/08/18.
//

import UIKit
import Alamofire
import SnapKit

class LoginViewController : UIViewController {
    
    let emailField = UITextField()
    let passworldField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(KeyChain.read(key: Token.accessToken))
//        print(KeyChain.read(key: Token.refreshToken))
        
        view.backgroundColor = .white
            emailViewLine()
            passwordViewLine()
        configureLoginButton()
        configureSignUpButton()
        logoView()
        loginAndSignUpTextField()
    }
    
    func postLogin() {
            let url = "http://192.168.107.1:8080/api/auth/login"
            var request = URLRequest(url: URL(string: url)!)
        
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            // POST 로 보낼 정보
        let params = ["email":emailField.text!,
                      "pw":passworldField.text! ] as Dictionary

            // httpBody 에 parameters 추가
            do {
                try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
            } catch {
                print("http Body Error")
            }

        AF.request(request).responseString() { (response) in
            switch response.response?.statusCode {
                case 200:
                    debugPrint(response)
                if let userDate = try? JSONDecoder().decode(TokenModel.self, from: response.data!) {
                    KeyChain.create(key: Token.accessToken, token: userDate.access_token)
                    KeyChain.create(key: Token.refreshToken, token: userDate.resfresh_token)
                    print("토큰 저장 성공🌹")
                    } else {
                        print("토큰 저장실패")
                    }
                        print("로그인 성공😁")
                        let goToMainTabBarVC = MainTapBarViewController()
                        goToMainTabBarVC.modalPresentationStyle = .fullScreen
                        self.present(goToMainTabBarVC, animated: true, completion: nil)

                default:
                    if response.response?.statusCode != 200 {
                        print("로그인 실패 🤬")
                        print(response)
                        print(request)
                        let AlertMassge = UIAlertController(title: "경고", message: "로그인 실패", preferredStyle: UIAlertController.Style.alert)
                        let ActionMassge = UIAlertAction(title: "다시 작성해주세요", style: UIAlertAction.Style.default, handler: nil)
                        
                        AlertMassge.addAction(ActionMassge)
                        self.present(AlertMassge, animated: true, completion: nil)
                }
            }
        }
    }
    
    func emailViewLine() {
        let emailview = UIView()
        let ColorC = UIColor(named: "Color-c")
        view.addSubview(emailview)
        emailview.backgroundColor = ColorC
        emailview.layer.cornerRadius = 20
        emailview.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.bottom.equalTo(-500)
            $0.leading.equalTo(45)
        }
    }
    
    func passwordViewLine() {
        let emailCheckCode = UIView()
        let ColorC = UIColor(named: "Color-c")
        view.addSubview(emailCheckCode)
        emailCheckCode.backgroundColor = ColorC
        emailCheckCode.layer.cornerRadius = 20
        emailCheckCode.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.bottom.equalTo(-420)
            $0.leading.equalTo(45)
        }
    }

    
    func logoView() {
        let imageView: UIImageView = {
            let logoImage = UIImageView()
            logoImage.backgroundColor = .white
            logoImage.image = UIImage(named: "NUGUGAELogo")
            logoImage.contentMode = .scaleAspectFit
            
            logoImage.translatesAutoresizingMaskIntoConstraints = false
            return logoImage
        }()
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints{
            $0.width.height.equalTo(150)
            $0.trailing.equalTo(-45)
            $0.top.equalTo(150)
            $0.leading.equalTo(45)
        }
    }
    
    func loginAndSignUpTextField() {
        
        emailField.borderStyle = .none
        view.addSubview(emailField)
        emailField.attributedPlaceholder = NSAttributedString(string: "please write Id...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        emailField.textColor = .black
        emailField.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.bottom.equalTo(-500)
            $0.leading.equalTo(65)
        }
        
        passworldField.borderStyle = .none
        passworldField.attributedPlaceholder = NSAttributedString(string: "please write password...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        passworldField.textColor = .black
        passworldField.isSecureTextEntry = true
        view.addSubview(passworldField)
        passworldField.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.bottom.equalTo(-420)
            $0.leading.equalTo(65)
        }
    }
    
    func configureLoginButton() {
        let loginButton = UIButton()
        let ColorA = UIColor(named: "Color-a")
        let ColorC = UIColor(named: "Color-c")
        loginButton.setTitle("Sign in", for: .normal)
        loginButton.setTitleColor(ColorC, for: .normal)
        loginButton.backgroundColor = ColorA
        loginButton.layer.cornerRadius = 10
        
        view.addSubview(loginButton)
        
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        loginButton.snp.makeConstraints{
            $0.height.equalTo(55)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.bottom.equalTo(-230)
            $0.leading.equalTo(45)
        }
        
        loginButton.addTarget(self, action: #selector(loginbuttonAction), for: .touchUpInside)
        
        }
    
    @objc func loginbuttonAction(sender: UIButton!){
        print(" 로그인 버튼 실행됨")
        postLogin()
    }
    
    func configureSignUpButton() {
        
        let signUpButton = UIButton()
        let ColorB = UIColor(named: "Color-b")
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(ColorB, for: .normal)
        signUpButton.backgroundColor = .white
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        
        view.addSubview(signUpButton)
        
        signUpButton.snp.makeConstraints{
            $0.height.equalTo(55)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.bottom.equalTo(-170)
            $0.leading.equalTo(45)
        }
        
        signUpButton.addTarget(self, action: #selector(signUpButtonAction), for: .touchUpInside)
        
        }
    @objc func signUpButtonAction(sender: UIButton!){
        print(" 회원가입 버튼 실행됨")
        let goToMainSignUpVC = SignUpViewController()
        goToMainSignUpVC.modalPresentationStyle = .fullScreen
        self.present(goToMainSignUpVC, animated: true, completion: nil)
    }
    
}


//view미리보기
import SwiftUI

struct LoginViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> LoginViewController {
        return LoginViewController()
    }
    
    func updateUIViewController(_ uiViewController: LoginViewController, context: Context) { }
    
    
    typealias UIViewControllerType = LoginViewController
}

@available(iOS 13.0.0, *)
struct LoginViewPreview: PreviewProvider {
    static var previews: some View {
        LoginViewControllerRepresentable()
    }
}
