//
//  SuccessViewController.swift
//  LoginScreenUI
//
//  Created by Mustafa Aktas on 17.06.2023.
//

import UIKit

class SuccessViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func exitButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "LoginPage")
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true)
    }
    

}
