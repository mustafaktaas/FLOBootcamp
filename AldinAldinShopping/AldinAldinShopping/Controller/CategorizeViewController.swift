//
//  CategorizeViewController.swift
//  AldinAldinShopping
//
//  Created by Mustafa Aktas on 29.06.2023.
//

import UIKit
import Alamofire
import SDWebImage

class CategorizeViewController: UIViewController {

    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    static var filteredProductList: [ProductModel] = []
    static var selectedCategory: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.layer.cornerRadius = 20
        tableView.layer.masksToBounds = true
        tableViewCellSetup()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.title = "mustafa"
        self.navigationItem.style = .editor
        tableView.showsVerticalScrollIndicator = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.layer.cornerRadius = 10
        tableView.layer.masksToBounds = true
        NetworkUtils.checkConnection(in: self) {
            NetworkUtils.retryButtonTapped(in: self)}
        CategorizeViewController.filteredProductList = []
        fetchCategoryProducts(category: CategorizeViewController.selectedCategory)
        categoryNameLabelSetup(name: CategorizeViewController.selectedCategory)
    }

    func tableViewCellSetup() {
        tableView.register(UINib(nibName: K.TableView.categorizedTableViewCell, bundle: nil), forCellReuseIdentifier: K.TableView.categorizedTableViewCell)
    }
    
    func categoryNameLabelSetup(name: String) {
        switch name {
        case "electronics":
            categoryNameLabel.text = "Electronics"
        case "jewelery":
            categoryNameLabel.text = "Jewelery"
        case "men's%20clothing":
            categoryNameLabel.text = "Men's clothing"
        case "women's%20clothing":
            categoryNameLabel.text = "Women's clothing"
        default:
            print("category name error")
        }
    }
    
    func changeVCCategoryToProductDetail(id: Int) {
        ProductDetailViewController.selectedProductID = id
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: K.Segues.productDetailViewController)
        show(vc, sender: self)
    }

    func fetchCategoryProducts(category: String) {
        print("\(K.Network.categoryURL)/\(category)")
       AF.request("\(K.Network.categoryURL)/\(category)").response { response in
       switch response.result {
       case .success(_):
           do {
               let productData = try JSONDecoder().decode([ProductData].self, from: response.data!)
               for data in productData {
                   CategorizeViewController.filteredProductList.append(ProductModel(id: data.id, title: data.title, price: Float(data.price), image: data.image, rate: Float(data.rating.rate), category: data.category, description: data.description, count: data.rating.count))
                   DispatchQueue.main.async {
                       self.tableView.reloadData()
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
}

extension CategorizeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategorizeViewController.filteredProductList.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.TableView.categorizedTableViewCell, for: indexPath) as! CategorizeTableViewCell
        let u = CategorizeViewController.filteredProductList[indexPath.row]
        cell.productNameLabel.text = u.title
        cell.productDescriptionLabel.text = u.description
        cell.productRateLabel.text = "⭐️ \(u.rate!) "
        cell.productPriceLabel.text = "$\(u.price!)$"
        cell.productImageView.sd_setImage(with: URL(string: u.image!), placeholderImage: UIImage(systemName: "photo"))
        return cell
    }
}

extension CategorizeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let productIdAtSelectedRow = CategorizeViewController.filteredProductList[indexPath.row].id {
            changeVCCategoryToProductDetail(id: productIdAtSelectedRow)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
     
