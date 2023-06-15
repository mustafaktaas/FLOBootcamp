//
//  LoginViewController.swift
//  LoginSignUpFirebaseAuth
//
//  Created by Mustafa Aktas on 12.06.2023.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButton(_ sender: Any) {
        validateText()
    }
    
    @IBAction func newAccountButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "SignUpPage")
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true)
    }
    
    func validateText () {
        if emailTxt.text?.isEmpty == true {
            print("No text for email field")
            return
        }
        
        if passwordTxt.text?.isEmpty == true {
            print("No text for password field")
            return
        }
        
        login()
    }
    
    func login () {
        Auth.auth().createUser(withEmail: emailTxt.text!, password: passwordTxt.text!) {
            [weak self] authResult, error in
            guard let strongSelf = self else {return}
            if let error = error {
                print(error.localizedDescription)
            }
            self?.checkUser()
        }
    }
    
    func checkUser () {
        if Auth.auth().currentUser != nil {
            print(Auth.auth().currentUser?.uid)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(identifier: "SuccessPage")
            viewController.modalPresentationStyle = .overFullScreen
            present(viewController, animated: true)
        }
    }

}
