//
//  OdevFaturaCevher.swift
//  OdevFaturaCevher
//
//  Created by Mustafa Aktas on 30.05.2023.
//

struct Cevher {
    let kod: String
    let fiyat: Double
    let isim: String
}

struct Tane {
    let kod: Int
    let etkisi: Double
    let isim: String
}

func cevherFiyat(cevherKodu: String) -> Double {
    switch cevherKodu {
    case "DMR":
        return 1500
    case "KRM":
        return 5000
    case "BKR":
        return 3000
    case "KMR":
        return 500
    default:
        return 0
    }
}

func taneEtkisi(taneKodu: Int) -> Double {
    switch taneKodu {
    case 1:
        return -0.15
    case 2:
        return -0.10
    case 3:
        return 0
    default:
        return 0
    }
}

func temizlikEtkisi(temizlikOrani: Double, birimFiyat: Double) -> Double {
    let temizOlmayanFiyat =  -(birimFiyat * (100 - temizlikOrani)/100)
    return temizOlmayanFiyat
}
func hesaplaMadenFaturasi() {
    print("** Cevher v1.0 **")
    
    print("*Müşteri'nin")
    print("Adı: ", terminator: "")
    let ad = readLine() ?? ""
    
    print("Soyadı: ", terminator: "")
    let soyad = readLine() ?? ""
    
    print("*Cevherin")
    print("İsimleri ve Kodları : Demir(DMR), Krom(KRM),Bakır(BKR), Kömür(KMR)")
    var cevherKodu: String?
    while cevherKodu == nil {
        print("Kodu: ", terminator: "")
        let input = readLine() ?? ""
        
        switch input {
        case "DMR", "KRM", "BKR", "KMR":
            cevherKodu = input
        default:
            print("Geçersiz cevher kodu. Lütfen tekrar deneyin.")
        }
    }
    
    var taneKodu: Int?
    while taneKodu == nil || taneKodu! < 1 || taneKodu! > 3 {
        print("Tane büyüklüğü (1-3): ", terminator: "")
        let input = Int(readLine() ?? "") ?? 0
        
        if input >= 1 && input <= 3 {
            taneKodu = input
        } else {
            print("Geçersiz tane büyüklüğü. Lütfen 1-3 aralığında bir değer girin.")
        }
    }
    
    var temizlikOrani: Double?
    while temizlikOrani == nil || taneKodu! <= 0 || taneKodu! > 100 {
        print("Temizlik oranı (%): ", terminator: "")
        let input = Double(readLine() ?? "") ?? 0
        
        if input > 0 && input <= 100 {
            temizlikOrani = input
        } else {
            print("Geçersiz temizlik oranı. Lütfen 0-100 aralığında bir değer girin.")
        }
    }
    
    var miktar: Double?
    while miktar == nil || miktar! <= 0 {
        print("Miktar (ton): ", terminator: "")
        let input = Double(readLine() ?? "") ?? 0
        
        if input > 0 {
            miktar = input
        } else {
            print("Geçersiz miktar. Lütfen pozitif bir sayı girin.")
        }
    }

    
    print("**************************************************")
    print("****************** Fatura ******************")
    print("Alıcı: \(ad) \(soyad)")
    
    let cevher = Cevher(kod: cevherKodu!, fiyat: cevherFiyat(cevherKodu: cevherKodu!), isim: cevherKodu == "DMR" ? "Demir" : cevherKodu == "KRM" ? "Krom" : (cevherKodu == "BKR" ? "Bakır" : "Kömür"))
    
    print("Cevher türü: \(cevher.isim)")
    print("Normal Birim Fiyat: \(cevher.fiyat) TON/TL")
    
    let tane = Tane(kod: taneKodu!, etkisi: taneEtkisi(taneKodu: taneKodu!), isim: taneKodu == 1 ? "Erik" : (taneKodu == 2 ? "Portakal" : "Karpuz"))
    
    let taneFiyatEtkisi = cevher.fiyat * tane.etkisi
    let taneFiyati = cevher.fiyat + taneFiyatEtkisi
    
    print("Tane: \(tane.isim) (-%\(abs(tane.etkisi)*100))")
    print("\(tane.isim) Fiyat: \(taneFiyati) TON/TL")
    
    let temizlikFiyatEtkisi = temizlikEtkisi(temizlikOrani: temizlikOrani!, birimFiyat: taneFiyati)
    let temizlikEtkiliFiyat = taneFiyati + temizlikFiyatEtkisi
    
    print("Temizlik: %\(temizlikOrani ?? 0) , Etkisi: \(temizlikFiyatEtkisi) TL")
    print("Temizlik Etkisi Sonrası")
    print("Birim fiyat: \(temizlikEtkiliFiyat) TON/TL")
    
    let toplam = temizlikEtkiliFiyat * miktar!
    let kdv = toplam * 0.08
    let genelToplam = toplam + kdv
    
    print("Toplam: \(toplam) TL")
    print("KDV (%8): \(kdv) TL")
    print("Genel Toplam: \(genelToplam) TL")
    
    print("\nMega Madencilik, 2023")
    print("**************************************************")
}

hesaplaMadenFaturasi()
