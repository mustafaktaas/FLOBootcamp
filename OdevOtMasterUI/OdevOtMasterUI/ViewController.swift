//
//  ViewController.swift
//  OdevOtMasterUI
//
//  Created by Mustafa Aktas on 28.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var otAdiLabelKekik: UILabel!
    @IBOutlet weak var otAdiLabelReyhan: UILabel!
    @IBOutlet weak var otAdiLabelFeslegen: UILabel!
    @IBOutlet weak var otAdiLabelNane: UILabel!
    
    @IBOutlet weak var otFiyatReyhanTextField: UITextField!
    @IBOutlet weak var otFiyatFeslegenTextField: UITextField!
    @IBOutlet weak var otFiyatNaneTextField: UITextField!
    @IBOutlet weak var otFiyatKekikTextField: UITextField!
    
    @IBOutlet weak var otTurSecimTextField: UITextField!
    
    @IBOutlet weak var otMiktarGirTextField: UITextField!
    
    @IBOutlet weak var otTazemiSwitch: UISwitch!
    
    var otBirimFiyat: [String: Double] = [:]
    var otTazelikEtkisi: [String: Double] = ["Kekik": -0.10, "Nane": -0.20, "Fesleğen": -0.10, "Reyhan": -0.25]
    
    // -------Ot birim fiyatlarını döndüren fonksiyon---------
    func otBirimFiyat(_ otAdi: String) -> Double? {
        return otBirimFiyat[otAdi]
    }
    
    // -------Tazeliğe göre fiyat düşüşünü hesaplayan fonksiyon---------
    func otTazelikEtkisi(_ otAdi: String, _ tazeMi: Bool) -> Double {
        let tazelikFaktoru = tazeMi ? 1.0 : 0.0
        let tazelikEtki = otTazelikEtkisi[otAdi] ?? 0.0
        return tazelikFaktoru * tazelikEtki
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let otIsimler = otTazelikEtkisi.keys
        let otAdiLabeller = [otAdiLabelKekik, otAdiLabelReyhan, otAdiLabelFeslegen, otAdiLabelNane]
        for (index, otAdi) in otIsimler.enumerated() {
            if let label = otAdiLabeller[index] {
                label.text = otAdi
            }
            
        }
    }
    
    @IBAction func otFiyatHesaplaButton(_ sender: UIButton) {
        
        otBirimFiyat["Reyhan"] = Double(otFiyatReyhanTextField.text ?? "") ?? 0.0
            otBirimFiyat["Fesleğen"] = Double(otFiyatFeslegenTextField.text ?? "") ?? 0.0
            otBirimFiyat["Nane"] = Double(otFiyatNaneTextField.text ?? "") ?? 0.0
            otBirimFiyat["Kekik"] = Double(otFiyatKekikTextField.text ?? "") ?? 0.0

        
        if let otAdi = otTurSecimTextField.text, let birimFiyat = otBirimFiyat(otAdi),
            let miktarStr = otMiktarGirTextField.text, let miktar = Double(miktarStr) {
            let tazeMi = otTazemiSwitch.isOn
            let tutar = birimFiyat * miktar
            let tazelikEtki = otTazelikEtkisi(otAdi, tazeMi)
            let toplamTutar = tutar + (tutar * tazelikEtki)
            let kdv = toplamTutar * 0.18
            let genelToplam = toplamTutar + kdv

            let faturaMessage = """
            ******************************
            Fatura:
            ---------------------------------------
            OT A.Ş.
            * \(otAdi): \(miktar)kg * \(birimFiyat) TL = \(tutar) TL
            Taze \(tazeMi ? "değil." : "mi.")
            KDV (%18): \(kdv) TL
            Genel Toplam: \(genelToplam) TL
            """

            let alertController = UIAlertController(title: "Fatura", message: faturaMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
            alertController.addAction(okAction)

            // Görüntülemek için mevcut view controller üzerinde çağırın
            present(alertController, animated: true, completion: nil)
        }
    }
}






