//
//  Sign up.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/06/27.
//

import UIKit
import SP

class SignUp: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var emailCheckCodeField: UITextField!
    @IBOutlet weak var passWordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        if(nameField.text == "" || passWordField.text == "") {
            let checkAgainAction = UIAlertController(title: "아이디와 패스워드를 확인해주세요", message: "다시 입력해주세요.", preferredStyle: .alert)
            checkAgainAction.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(checkAgainAction, animated: true, completion: nil)
        } else {
            let vcName = self.storyboard?.instantiateViewController(withIdentifier: "secondVC")
            self.present(vcName!, animated: true, completion: nil)
        }
    }
}
