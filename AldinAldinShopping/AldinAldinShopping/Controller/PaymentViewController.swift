//
//  PaymentViewController.swift
//  AldinAldinShopping
//
//  Created by Mustafa Aktas on 12.07.2023.
//

import UIKit
import Firebase

class PaymentViewController: UIViewController {

    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var cardNoTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var addressSurnameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var adressNameTextField: UITextField!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    private let currentUserUid = Auth.auth().currentUser?.uid
    private let database = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false

    }
    
    @IBAction func checkoutButton(_ sender: UIButton) {
        
        let userRef = database.collection("users").document(currentUserUid!)
        if CartViewController.cartItems.count == 0 {
            DuplicateFuncs.alertMessage(title: "ERROR", message: "Your cart is empty", vc: self)
        } else {
            for product in CartViewController.cartItems {
                if let productId = product.id {
                    userRef.updateData([
                        "\(productId)" : FieldValue.delete()
                    ]) { error in
                        if let error = error {
                            print("error: \(error)")
                        } else {
                            CartViewController.cartItems = []
                            DuplicateFuncs.alertMessage(title: "Order Success", message: "Your order has been placed", vc: self)
                        }
                    }
                }
            }
        }
    }
    
}
