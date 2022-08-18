//
//  SignUpVC.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/08/18.
//

import UIKit

class SignUpViewController : UIViewController {
    
    let NameField = UITextField()
    let idFidld = UITextField()
    let passworldField = UITextField()
    let ageField = UITextField()
    
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
        certificationViewLine()
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
    func certificationViewLine() {
        let certification = UIView()
        let ColorB = UIColor(named: "Color-b")
        view.addSubview(certification)
        certification.backgroundColor = ColorB
        certification.layer.cornerRadius = 20
        certification.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.width.equalTo(50)
            $0.trailing.equalTo(-45)
            $0.top.equalTo(505)
            $0.leading.equalTo(338)
        }
    }
    
    func NameAndIdAndPassAndAgeTextField() {
        
        NameField.borderStyle = .none
        view.addSubview(NameField)
        NameField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        NameField.textColor = .black
        NameField.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.top.equalTo(295)
            $0.leading.equalTo(65)
        }
        
        idFidld.borderStyle = .none
        view.addSubview(idFidld)
        idFidld.attributedPlaceholder = NSAttributedString(string: "Id", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        idFidld.textColor = .black
        idFidld.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.top.equalTo(365)
            $0.leading.equalTo(65)
        }
        
        passworldField.borderStyle = .none
        passworldField.attributedPlaceholder = NSAttributedString(string: "Passworld", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
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
        
        ageField.borderStyle = .none
        view.addSubview(ageField)
        ageField.attributedPlaceholder = NSAttributedString(string: "Age", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        ageField.textColor = .black
        ageField.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.top.equalTo(505)
            $0.leading.equalTo(65)
        }
    }
    
    func configureSignUpButton() {
        let loginButton = UIButton()
        loginButton.setTitle("Sign in", for: .normal)
        loginButton.backgroundColor = .black
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(loginButton)
        
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        loginButton.snp.makeConstraints{
            $0.height.equalTo(55)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.bottom.equalTo(-200)
            $0.leading.equalTo(45)
        }
        
        loginButton.addTarget(self, action: #selector(loginbuttonAction), for: .touchUpInside)
        
        }
    
    @objc func loginbuttonAction(sender: UIButton!){
//        postsignUp()
        print("------------------------------")
        print("Name : \(NameField.text!)")
        print("Id : \(idFidld.text!)")
        print("Password : \(passworldField.text!)")
        print("Age : \(ageField.text!)")
        print("------------------------------")

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
