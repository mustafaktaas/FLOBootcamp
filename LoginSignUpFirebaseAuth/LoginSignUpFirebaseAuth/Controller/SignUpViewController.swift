//
//  SignUpViewController.swift
//  LoginSignUpFirebaseAuth
//
//  Created by Mustafa Aktas on 12.06.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        if emailTxt.text?.isEmpty == true {
            print("No text for email field")
            return
        }
        
        if passwordTxt.text?.isEmpty == true {
            print("No text for password field")
            return
        }
        
        signUp()
    }
    
    @IBAction func goLoginButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "LoginPage")
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true)
    }
    
    func signUp(){
        Auth.auth().createUser(withEmail: emailTxt.text!, password: passwordTxt.text!) {
            (authResult, error) in
            guard let user = authResult?.user, error == nil
            else {
                print("Error \(error?.localizedDescription)")
                return
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(identifier: "SuccessPage")
            viewController.modalPresentationStyle = .overFullScreen
            self.present(viewController, animated: true)
            
        }
    }
    
    
}
