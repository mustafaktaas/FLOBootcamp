//
//  TabBarViewController.swift
//  AldinAldinShopping
//
//  Created by Mustafa Aktas on 27.06.2023.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.tabBar.unselectedItemTintColor = .darkGray
        self.tabBar.tintColor = .systemCyan
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NetworkUtils.checkConnection(in: self) {
            NetworkUtils.retryButtonTapped(in: self)}
    }
    
    override func tabBar( _ tabBar: UITabBar, didSelect item: UITabBarItem) {
        SimpleAnimationWhenSelectItem(item: item)
    }

    func SimpleAnimationWhenSelectItem( item: UITabBarItem) {
        guard let barItemView = item.value(forKey: "view") as? UIView else { return }


        let timeInterval: TimeInterval = 0.4
        let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.5) {
            barItemView.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
        }
        propertyAnimator.addAnimations({
            barItemView.transform = .identity
        }, delayFactor: CGFloat(timeInterval))
        propertyAnimator.startAnimation()
    }

}
