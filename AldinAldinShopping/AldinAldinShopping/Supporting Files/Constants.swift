//
//  Constants.swift
//  AldinAldinShopping
//
//  Created by Mustafa Aktas on 27.06.2023.
//

import Foundation

struct K {
    struct Segues {
        static let loginToHome = "loginToHome"
        static let registerToLogin = "registerToLogin"
        static let forgetToLogin = "forgetToLogin"
        static let categoryTableView = "categoryTableView"
        static let productDetailViewController = "productDetailViewController"
        static let loginToForget = "loginToForget"
    }
    
    struct StoryboardID {
        static let welcomeVC = "WelcomeVC"
    }
    
    struct CollectionViews {
        static let topCollectionViewNibNameAndIdentifier = "CategoryCollectionViewCell"
        static let bottomCollectionViewNibNameAndIdentifier = "ProductCollectionViewCell"
    }
    
    struct Network {
        static let baseURL = "https://fakestoreapi.com/products"
        static let categoryURL = "https://fakestoreapi.com/products/category"
        static let categoriesURL = "https://fakestoreapi.com/products/categories"
    }
    
    struct TableView {
        static let categorizedTableViewCell = "CategorizeTableViewCell"
        static let cartTableViewCell = "CartTableViewCell"
    }
    
}
