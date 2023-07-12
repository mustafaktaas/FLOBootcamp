//
//  ForgetPasswordViewController.swift
//  AldinAldinShopping
//
//  Created by Mustafa Aktas on 27.06.2023.
//

import UIKit
import Firebase

class ForgetPasswordViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        NetworkUtils.checkConnection(in: self) {
            NetworkUtils.retryButtonTapped(in: self)}
    }
    
    @IBAction func newPasswordButton(_ sender: UIButton) {
        if let email = emailTextField.text {
            if email == "" {
                DuplicateFuncs.alertMessage(title: "ERROR", message: "Please enter a valid email", vc: self)
            } else {
                Auth.auth().sendPasswordReset(withEmail: email) { error in
                    if let error = error {
                        DuplicateFuncs.alertMessage(title: "Network error", message: error.localizedDescription, vc: self)
                    } else {
                        DuplicateFuncs.alertMessageWithHandler(title: "Success", message: "Please check your email", vc: self) {
                            self.performSegue(withIdentifier: K.Segues.forgetToLogin, sender: self)
                        }
                    }
                }
            }
        }
    }
    

}
