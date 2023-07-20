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
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var adressNameTextField: UITextField!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    private let currentUserUid = Auth.auth().currentUser?.uid
    private let database = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        dateTextField.textContentType = .dateTime
        setupTextFields()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        dateTextField.textContentType = .dateTime
    }
    
    @IBAction func checkoutButton(_ sender: UIButton) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let paymentPage = PaymentPage(context: context)
        paymentPage.address = addressTextField.text
        paymentPage.addressFullName = adressNameTextField.text
        paymentPage.addressPhoneNumber = Int64(phoneTextField.text ?? "") ?? 0
        //paymentPage.cardDate = dateTextField.text
        paymentPage.cardNo = Int64(cardNoTextField.text ?? "") ?? 0
        paymentPage.cardCvv = Int16(cvvTextField.text ?? "") ?? 0
        paymentPage.cardFullName = nameTextField.text
        
        
        
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
    
    func setupTextFields() {
        // dateTextField için regular expression ekleyelim
        dateTextField.delegate = self
        dateTextField.addTarget(self, action: #selector(dateTextFieldEditingChanged(_:)), for: .editingChanged)
        
        // cardNoTextField için regular expression ekleyelim
        cardNoTextField.delegate = self
        cardNoTextField.addTarget(self, action: #selector(cardNoTextFieldEditingChanged(_:)), for: .editingChanged)
        
        // cvvTextField için regular expression ekleyelim
        cvvTextField.delegate = self
        cvvTextField.addTarget(self, action: #selector(cvvTextFieldEditingChanged(_:)), for: .editingChanged)
        
        // phoneTextField için regular expression ekleyelim
        phoneTextField.delegate = self
        phoneTextField.addTarget(self, action: #selector(phoneTextFieldEditingChanged(_:)), for: .editingChanged)
        
        // addressTextField için sadece metin ve boşluk girişi kabul edelim
        addressTextField.delegate = self
        
        // adressNameTextField için sadece metin ve boşluk girişi kabul edelim
        adressNameTextField.delegate = self
        
        // nameTextField için sadece metin ve boşluk girişi kabul edelim
        nameTextField.delegate = self
    }

    // dateTextField için girilen değeri düzenlemek için bir fonksiyon
    @objc func dateTextFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text {
            // Girişten sadece sayıları filtrelemek için
            let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
            let filteredText = regex.stringByReplacingMatches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count), withTemplate: "")

            // MM/YY formatına uygun olacak şekilde düzenlemek için
            let formattedText = formatMMYY(filteredText)

            textField.text = formattedText
        }
    }

    // cardNoTextField için girilen değeri düzenlemek için bir fonksiyon
    @objc func cardNoTextFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text {
            // Girişten sadece sayıları filtrelemek için
            let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
            let filteredText = regex.stringByReplacingMatches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count), withTemplate: "")

            // "1234 1234 1234 1234" gibi bir format oluşturmak için
            let formattedText = formatCardNumber(filteredText)

            textField.text = formattedText
        }
    }

    // cvvTextField için girilen değeri düzenlemek için bir fonksiyon
    @objc func cvvTextFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text {
            // Girişten sadece sayıları filtrelemek için
            let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
            let filteredText = regex.stringByReplacingMatches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count), withTemplate: "")

            // Maksimum 3 karakter sınırını kontrol edelim
            if filteredText.count > 3 {
                let index = filteredText.index(filteredText.startIndex, offsetBy: 3)
                textField.text = String(filteredText[..<index])
            } else {
                textField.text = filteredText
            }
        }
    }

    // phoneTextField için girilen değeri düzenlemek için bir fonksiyon
    @objc func phoneTextFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text {
            // Girişten sadece sayıları filtrelemek için
            let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
            let filteredText = regex.stringByReplacingMatches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count), withTemplate: "")

            // Maksimum 11 karakter sınırını kontrol edelim
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
    
    // ... diğer fonksiyonlar ve işlemler
}

// UITextFieldDelegate için extension
extension PaymentViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Sadece metin ve boşluk girişine izin verelim
        if textField == addressTextField || textField == adressNameTextField || textField == nameTextField {
            let allowedCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacterSet.isSuperset(of: characterSet)
        }
        return true
    }
}
