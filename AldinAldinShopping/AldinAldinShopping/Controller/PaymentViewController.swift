//
//  PaymentViewController.swift
//  AldinAldinShopping
//
//  Created by Mustafa Aktas on 12.07.2023.
//

import UIKit
import Firebase

class PaymentViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var cardNoTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var adressNameTextField: UITextField!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    private let currentUserUid = Auth.auth().currentUser?.uid
    private let database = Firestore.firestore()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        dateTextField.textContentType = .dateTime
        setupTextFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        dateTextField.textContentType = .dateTime
    }
    
    //MARK: - Interaction handlers
    @IBAction func checkoutButton(_ sender: UIButton) {
        
        guard let dateText = dateTextField.text, !dateText.isEmpty,
              let cardNoText = cardNoTextField.text, !cardNoText.isEmpty,
              let addressText = addressTextField.text, !addressText.isEmpty,
              let phoneText = phoneTextField.text, !phoneText.isEmpty,
              let adressNameText = adressNameTextField.text, !adressNameText.isEmpty,
              let cvvText = cvvTextField.text, !cvvText.isEmpty,
              let nameText = nameTextField.text, !nameText.isEmpty else {
            DuplicateFuncs.alertMessage(title: "Error", message: "All fields are required.", vc: self)
            return
        }
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let paymentPage = PaymentPage(context: context)
        paymentPage.address = addressTextField.text
        paymentPage.addressFullName = adressNameTextField.text
        paymentPage.addressPhoneNumber = Int64(phoneTextField.text ?? "") ?? 0
        paymentPage.cardCvv = Int16(cvvTextField.text ?? "") ?? 0
        paymentPage.cardFullName = nameTextField.text
        
        let cardNoWithoutSpaces = cardNoTextField.text?.replacingOccurrences(of: " ", with: "")
        paymentPage.cardNo = Int64(cardNoWithoutSpaces ?? "") ?? 0
        
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/yy"
            
            if let dateText = dateTextField.text, let cardDate = dateFormatter.date(from: dateText) {
                paymentPage.cardDate = cardDate
            } else {
                DuplicateFuncs.alertMessage(title: "Error", message: "Invalid card date format.", vc: self)
                return
            }
        
        do {
            try context.save()
        } catch {
            print("Error saving data to Core Data: \(error)")
        }
        
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
                            DuplicateFuncs.alertMessageWithHandler(title: "Order Success", message: "Your order has been placed", vc: self) {
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: "tabbarVC")
                                self.show(vc, sender: self)
                            }
                        }
                    }
                }
            }
        }
    }
    
    //MARK: - Functions
    func setupTextFields() {
        dateTextField.delegate = self
        dateTextField.addTarget(self, action: #selector(dateTextFieldEditingChanged(_:)), for: .editingChanged)
        
        cardNoTextField.delegate = self
        cardNoTextField.addTarget(self, action: #selector(cardNoTextFieldEditingChanged(_:)), for: .editingChanged)
        
        cvvTextField.delegate = self
        cvvTextField.addTarget(self, action: #selector(cvvTextFieldEditingChanged(_:)), for: .editingChanged)
        
        phoneTextField.delegate = self
        phoneTextField.addTarget(self, action: #selector(phoneTextFieldEditingChanged(_:)), for: .editingChanged)
        
        addressTextField.delegate = self
        
        adressNameTextField.delegate = self
        
        nameTextField.delegate = self
    }
    
    @objc func dateTextFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text {
            let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
            let filteredText = regex.stringByReplacingMatches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count), withTemplate: "")
            
            let formattedText = formatMMYY(filteredText)
            textField.text = formattedText
        }
    }
    
    @objc func cardNoTextFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text {
            let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
            let filteredText = regex.stringByReplacingMatches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count), withTemplate: "")
            
            let formattedText = formatCardNumber(filteredText)
            textField.text = formattedText
        }
    }
    
    @objc func cvvTextFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text {
            let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
            let filteredText = regex.stringByReplacingMatches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count), withTemplate: "")
            
            if filteredText.count > 3 {
                let index = filteredText.index(filteredText.startIndex, offsetBy: 3)
                textField.text = String(filteredText[..<index])
            } else {
                textField.text = filteredText
            }
        }
    }
    
    @objc func phoneTextFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text {
            let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
            let filteredText = regex.stringByReplacingMatches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count), withTemplate: "")
            
            if filteredText.count > 11 {
                let index = filteredText.index(filteredText.startIndex, offsetBy: 11)
                textField.text = String(filteredText[..<index])
            } else {
                textField.text = filteredText
            }
        }
    }
    
    func formatMMYY(_ text: String) -> String {
        var formattedText = ""
        var counter = 0
        
        for char in text {
            if counter == 2 {
                formattedText += "/"
            }
            if counter >= 4 {
                break
            }
            formattedText += String(char)
            counter += 1
        }
        
        return formattedText
    }
    
    func formatCardNumber(_ text: String) -> String {
        var formattedText = ""
        var counter = 0
        
        for char in text {
            if counter > 0 && counter % 4 == 0 {
                formattedText += " "
            }
            if counter >= 16 {
                break
            }
            formattedText += String(char)
            counter += 1
        }
        
        return formattedText
    }
    
}

//MARK: - Extensions
extension PaymentViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == addressTextField || textField == adressNameTextField || textField == nameTextField {
            let allowedCharacterSet = CharacterSet(charactersIn: "abcdefghiıjklmnoöpqrsştuüvwxyzABCDEFGHIİJKLMNOÖPQRSŞTUÜVWXYZ ")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacterSet.isSuperset(of: characterSet)
        }
        return true
    }
}
