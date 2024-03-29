//
//  RegisterViewController.swift
//  AldinAldinShopping
//
//  Created by Mustafa Aktas on 27.06.2023.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    //MARK: - Properties
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    private let database = Firestore.firestore()
    private var authUser: FirebaseAuth.User? {
        Auth.auth().currentUser
    }
    
    //MARK: - Interaction handlers
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        NetworkUtils.checkConnection(in: self) {
            NetworkUtils.retryButtonTapped(in: self)}
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text, let confirmPassword = confirmPasswordTextField.text, let username = usernameTextField.text {
            if isPasswordsMatch(password: password, confirmPassword: confirmPassword) {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let error = error {
                        DuplicateFuncs.alertMessage(title: "ERROR", message: error.localizedDescription, vc: self)
                    } else {
                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                        changeRequest?.displayName = self.usernameTextField.text
                        changeRequest?.commitChanges(completion: { error in
                            if let error = error {
                                DuplicateFuncs.alertMessage(title: "FIRESTORE ERROR", message: error.localizedDescription, vc: self)
                            }
                        })
                        guard let userUid = authResult?.user.uid else { return }

                        self.database.collection("users").document(userUid).collection("userInfo").document(userUid).setData([
                            "username": username,
                            "email": email,
                            "id": userUid
                        ]) { error in
                            if let error = error {
                                DuplicateFuncs.alertMessage(title: "ERROR", message: error.localizedDescription, vc: self)
                            }
                        }
                        
                        self.database.collection("users").document(userUid).setData([:])
                        
                        self.sendVerificationMail()
                        DuplicateFuncs.alertMessageWithHandler(title: "Verify your email", message: "Verification mail sent", vc: self) {
                            self.performSegue(withIdentifier: K.Segues.registerToLogin, sender: self)
                        }
                    }
                }
            } else {
                DuplicateFuncs.alertMessage(title: "ERROR", message: "Passwords do not match!", vc: self)
            }
        }
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: K.Segues.registerToLogin, sender: self)
    }
    
    //MARK: - Functions
    func sendVerificationMail() {
        if authUser != nil && !authUser!.isEmailVerified {
            authUser?.sendEmailVerification(completion: { error in
                if let error = error {
                    DuplicateFuncs.alertMessage(title: "ERROR", message: error.localizedDescription, vc: self)
                }
            })
        } else {
            // Either the user is not available, or the user is already verified.
            DuplicateFuncs.alertMessage(title: "ERROR", message: "e-mail already verified", vc: self)
        }
    }
    
    func isPasswordsMatch(password: String, confirmPassword: String) -> Bool {
        if let password = passwordTextField.text, let passwordConfirm = confirmPasswordTextField.text {
            if password == passwordConfirm {
                return true
            }
        }
        return false
    }
}
    

