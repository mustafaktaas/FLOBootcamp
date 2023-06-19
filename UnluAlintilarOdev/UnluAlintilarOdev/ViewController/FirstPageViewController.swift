//
//  FirstPageViewController.swift
//  UnluAlintilarOdev
//
//  Created by Mustafa Aktas on 19.06.2023.
//

import UIKit

class FirstPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "AuthorPage")
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true)
    }
    
}
