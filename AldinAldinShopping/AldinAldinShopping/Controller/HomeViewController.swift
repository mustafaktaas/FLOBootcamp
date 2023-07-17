//
//  HomeViewController.swift
//  AldinAldinShopping
//
//  Created by Mustafa Aktas on 27.06.2023.
//

import UIKit
import Alamofire
import SDWebImage

class HomeViewController: UIViewController {

    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    static var productList: [ProductModel] = []
    static var categoryList: [CategoryModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.hidesBarsOnSwipe = true
        categoryCollectionView.isScrollEnabled = false
        productCollectionView.showsVerticalScrollIndicator = false
        collectionSetup()
        tabBarSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.hidesBarsOnSwipe = false
        NetworkUtils.checkConnection(in: self) {
            NetworkUtils.retryButtonTapped(in: self)}
        fetchCategories()
        fetchProducts()
    }

    func fetchProducts() {
        HomeViewController.productList  = []
        AF.request(K.Network.baseURL).response { response in
            switch response.result {
            case .success(_):
                do {
                    let productData = try JSONDecoder().decode([ProductData].self, from: response.data!)
                    for data in productData {
                        HomeViewController.productList.append(ProductModel(id: data.id, title: data.title, price: Float(data.price), image: data.image, rate: Float(data.rating.rate), category: data.category, description: data.description, count: data.rating.count))
                        DispatchQueue.main.async {
                            self.productCollectionView.reloadData()
                        }
                    }
                } catch
                let error {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchCategories() {
        AF.request(K.Network.categoriesURL).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let categories = try JSONDecoder().decode([String].self, from: data!)
                    for category in categories {
                        HomeViewController.categoryList.append(CategoryModel(category: category))
                    }
                    DispatchQueue.main.async {
                        self.categoryCollectionView.reloadData()
                    }
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                print("error on fetchCategories func: \(error.localizedDescription)")
            }
        }
    }
    
    func tabBarSetup() {
        self.tabBarController?.navigationItem.hidesBackButton = true
        
        if let tabBarController = self.tabBarController, let tabBarItems = tabBarController.tabBar.items {
            let desiredTabIndex = 1 // Anasayfa sekmesinin index numarasını buraya yazın
            
            if desiredTabIndex < tabBarItems.count {
                tabBarItems[desiredTabIndex].badgeValue = "0"
            }
        }
    }
    
    func collectionSetup() {
        categoryCollectionView.register(UINib(nibName: K.CollectionViews.topCollectionViewNibNameAndIdentifier, bundle: nil), forCellWithReuseIdentifier: K.CollectionViews.topCollectionViewNibNameAndIdentifier)
        
        categoryCollectionView.collectionViewLayout = CategoryCollectionViewFlowLayout(sutunSayisi: 2, minSutunAraligi: 5, minSatirAraligi: 5)
        
        
        productCollectionView.register(UINib(nibName: K.CollectionViews.bottomCollectionViewNibNameAndIdentifier, bundle: nil), forCellWithReuseIdentifier: K.CollectionViews.bottomCollectionViewNibNameAndIdentifier)
        
        productCollectionView.collectionViewLayout = ProductCollectionViewFlowLayout(sutunSayisi: 2, minSutunAraligi: 5, minSatirAraligi: 5)
    }
    
    func changeVCcategoryToTableView(category: String) {
        switch category {
            
        case "electronics":
            CategorizeViewController.selectedCategory = "electronics"
            
        case "jewelery":
            CategorizeViewController.selectedCategory = "jewelery"
            
        case "men's clothing":
            CategorizeViewController.selectedCategory = "men's%20clothing"
            
        case "women's clothing":
            CategorizeViewController.selectedCategory = "women's%20clothing"
            
        default:
            DuplicateFuncs.alertMessage(title: "Category Error", message: "", vc: self)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: K.Segues.categoryTableView)
        show(vc, sender: self)
    }
    
    func changeVCHomeToProductDetail(id: Int) {
        ProductDetailViewController.selectedProductID = id
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: K.Segues.productDetailViewController)
        show(vc, sender: self)
    }
    
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
            
        case categoryCollectionView:
            return HomeViewController.categoryList.count
            
        case productCollectionView:
            return HomeViewController.productList.count
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
            
        case categoryCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.CollectionViews.topCollectionViewNibNameAndIdentifier, for: indexPath) as! CategoryCollectionViewCell
            let category = HomeViewController.categoryList[indexPath.row].category
            cell.categoryNameLabel.text = category?.capitalized
            
            switch category {
            case "electronics":
                cell.categoryImageView.image = UIImage(named: "electronics.png")
            case "jewelery":
                cell.categoryImageView.image = UIImage(named: "jewelery.png")
            case "men's clothing":
                cell.categoryImageView.image = UIImage(named: "man.png")
            case "women's clothing":
                cell.categoryImageView.image = UIImage(named: "woman.png")
            default:
                cell.categoryImageView.image = UIImage(systemName: "questionmark.square.dashed")
            }
            return cell
            
        case productCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.CollectionViews.bottomCollectionViewNibNameAndIdentifier, for: indexPath) as! ProductCollectionViewCell
            let u = HomeViewController.productList[indexPath.row]
            cell.spinner.startAnimating() // Spinner'ı başlat
            cell.productImageView.sd_setImage(with: URL(string: u.image!), placeholderImage: UIImage(systemName: "photo.on.rectangle.angled")) { (image, error, cacheType, url) in
                        // Fotoğraf yüklendikten sonra
                        cell.spinner.stopAnimating() // Spinner'ı durdur
                    }
            cell.productNameLabel.text = u.title
            cell.productRateLabel.text = "⭐️ \(u.rate!) "
            cell.productPriceLabel.text = "$\(u.price!)"
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}


extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
            
        case categoryCollectionView:
            // TODO: Safely unwrapped index controlü koy
            if let category = HomeViewController.categoryList[indexPath.row].category {
                changeVCcategoryToTableView(category: category)
            }
            
        case productCollectionView:
            if let product = HomeViewController.productList[indexPath.row].id {
                changeVCHomeToProductDetail(id: product)
            }
            
        default:
            print("error at didSelectItemAt")
            break
        }
    }
}

