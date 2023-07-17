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
        self.tabBar.unselectedItemTintColor = UIColor(white: 0, alpha: 0.4)
        self.tabBar.tintColor = UIColor(hexString: "#5f9ba4")
        self.tabBar.layer.cornerRadius = self.tabBar.frame.height / 1.1

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

extension UIColor {
    convenience init?(hexString: String) {
        var formattedString = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if formattedString.hasPrefix("#") {
            formattedString.remove(at: formattedString.startIndex)
        }
        
        if formattedString.count != 6 {
            return nil
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: formattedString).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
