//
//  LoginViewController.swift
//  AldinAldinShopping
//
//  Created by Mustafa Aktas on 27.06.2023.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    //MARK: - Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var authUser: FirebaseAuth.User? {
        Auth.auth().currentUser
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkUtils.checkConnection(in: self) {
                    NetworkUtils.retryButtonTapped(in: self)
                }
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = UIColor.darkGray
        UINavigationBar.appearance().tintColor = UIColor.darkGray
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
            // Connection Check
            NetworkUtils.checkConnection(in: self) {
                NetworkUtils.retryButtonTapped(in: self)
            }
        }
    
    //MARK: - Interaction handlers
    @IBAction func signInButton(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    DuplicateFuncs.alertMessage(title: "ERROR", message: e.localizedDescription, vc: self)
                } else {
                    if self.isEmailVerified() {
                        DuplicateFuncs.alertMessage(title: "Email not verified", message: "Please verify your e-mail", vc: self)
                    } else {
                        self.performSegue(withIdentifier: K.Segues.loginToHome, sender: self)
                    }
                }
            }
        }
    }
    
    @IBAction func forgetPasswordButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: K.Segues.loginToForget, sender: self)
    }
    
    //MARK: - Functions
    func isEmailVerified() -> Bool {
        if authUser != nil && !authUser!.isEmailVerified {
            return true
        }
        return false
    }
}
