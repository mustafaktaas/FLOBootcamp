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

malEkle()
