//
//  HomeViewController.swift
//  AldinAldinShopping
//
//  Created by Mustafa Aktas on 27.06.2023.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarSetup()
    }
    
    func tabBarSetup() {
        self.tabBarController?.navigationItem.hidesBackButton = true
        tabBarController!.tabBar.items?[1].badgeValue = "0"
    }


}
