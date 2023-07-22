//
//  ViewController.swift
//  AldinAldinShopping
//
//  Created by Mustafa Aktas on 27.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
            // Connection Check
            NetworkUtils.checkConnection(in: self) {
                NetworkUtils.retryButtonTapped(in: self)
            }
        }

}

