//
//  ViewController.swift
//  LoginScreenUI
//
//  Created by Mustafa Aktas on 12.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        guard let username = usernameTextField.text,
              let password = passwordTextField.text else {
            return
        }
        
        if let person = PersonList.first(where: { $0.username == username && $0.password == password }) {
            navigateToSuccessPage()
        } else {
            showAlert()
        }
    }
    
    
    func navigateToSuccessPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "SuccessPage")
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Hata", message: "Kullanıcı adı veya şifre yanlış.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

