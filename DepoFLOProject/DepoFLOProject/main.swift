import Foundation

// DepoFLO Project

// ---Stoğu tutan dictionary yapısı---
var stoklar = ["U01": 0, "U02": 0, "U03": 0]
// ---Programdaki son yapılan işlemi tutan değişken---
var sonIslem: String?

// ---Hangi ürün ile işlem yapmak istediğimizi seçtiğimiz fonk---
func malTuruMenu() -> Int {
    print("1- Ayakkabı")
    print("2- Çanta")
    print("3- Gözlük")
    print("4- Vazgeç")
    print("Seçim=")
    
    if let secim = readLine(), let secimInt = Int(secim) {
        return secimInt
    }
    return 0
}

// ---Bu istediğimz üründen istediğimiz adette eklememizi sağlayan fonk---
func malEkle() {
    let secim = malTuruMenu()
    guard secim != 4 else { return }
    
    var urunKodu = ""
    var urunAdi = ""
    
    switch secim {
    case 1:
        urunKodu = "U01"
        urunAdi = "Ayakkabı"
    case 2:
        urunKodu = "U02"
        urunAdi = "Çanta"
    case 3:
        urunKodu = "U03"
        urunAdi = "Gözlük"
    default:
        break
    }
    
    print("\(urunAdi) Ekleme")
    print("-------------------------------")
    
    var toplamMiktar = 0
    var miktar = 0
    
    repeat {
        print("Miktarı Giriniz (çıkış için 0): ", terminator: "")
        if let giris = readLine(), let miktarInt = Int(giris) {
            miktar = miktarInt
        }
        
        toplamMiktar += miktar
    } while miktar != 0
    
    stoklar[urunKodu, default: 0] += toplamMiktar
    print("\(urunAdi) stoğuna toplam \(toplamMiktar) adet \(urunAdi) eklendi.")
    sonIslem = "\(urunAdi) stoğuna toplam \(toplamMiktar) adet \(urunAdi) eklendi."
}


func malCikar() {
    let secim = malTuruMenu()
    guard secim != 4 else { return }
    
    var urunKodu = ""
    var urunAdi = ""
    
    switch secim {
    case 1:
        urunKodu = "U01"
        urunAdi = "Ayakkabı"
    case 2:
        urunKodu = "U02"
        urunAdi = "Çanta"
    case 3:
        urunKodu = "U03"
        urunAdi = "Gözlük"
    default:
        break
    }
    
    let stokMiktar = stoklar[urunKodu, default: 0]
    
    print("\(urunAdi) Çıkartma, Stok Miktarı= \(stokMiktar) adet")
    print("-------------------------------")
    
    var toplamCikartilan = 0
    var miktar = 0
    
    repeat {
        print("Miktarı Giriniz (çıkış için 0): ", terminator: "")
        if let giris = readLine(), let miktarInt = Int(giris) {
            miktar = miktarInt
        }
        
        toplamCikartilan += miktar
        if toplamCikartilan > stokMiktar {
            print("Stokta bu kadar yok, \(stokMiktar - (toplamCikartilan - miktar)) adet kaldı...")
            toplamCikartilan -= miktar
        }
    } while miktar != 0
    
    stoklar[urunKodu] = max(0, stokMiktar - toplamCikartilan)
    print("\(urunAdi) stoğuna toplam \(toplamCikartilan) adet \(urunAdi) eklendi.")
    sonIslem = "\(urunAdi) stoğundan toplam \(toplamCikartilan) adet \(urunAdi) çıkarıldı."
}


func menu() {
    var secim = 0
    
    repeat {
        print("---- DepoFLO v1.0 ----")
        print("1- Mal Ekle")
        print("2- Mal Çıkart")
        print("3- Çık")
        print("Seçim: ", terminator: "")
        
        if let giris = readLine(), let secimInt = Int(giris) {
            secim = secimInt
        }
        
        switch secim {
        case 1:
            malEkle()
        case 2:
            malCikar()
        case 3:
            print("Program sonlandırılıyor...")
        default:
            print("Geçersiz bir seçim yaptınız.")
        }
        
        print()
    } while secim != 3
}

menu()
