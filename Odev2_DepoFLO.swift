import Foundation

// DepoFLO Project

var stoklar = ["U01": 0, "U02": 0, "U03": 0]
var sonIslem: String?

func malEkle() {
    print("1- Ayakkabı")
    print("2- Çanta")
    print("3- Gözlük")
    print("4- Vazgeç")
    print("Seçim=")
    
    if let secim = readLine() {
        guard let secimInt = Int(secim) else { return }
        guard secimInt != 4 else { return }
        
        var urunKodu = ""
        var urunAdi = ""
        
        switch secim {
        case "1":
            urunKodu = "U01"
            urunAdi = "Ayakkabı"
        case "2":
            urunKodu = "U02"
            urunAdi = "Çanta"
        case "3":
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
        sonIslem = "\(urunAdi) stoğuna toplam \(toplamMiktar) adet \(urunAdi) eklendi."
        print(sonIslem!)
    }
}


func malCikar() {
    print("1- Ayakkabı")
    print("2- Çanta")
    print("3- Gözlük")
    print("4- Vazgeç")
    print("Seçim=")
    
    if let secim = readLine() {
        guard let secimInt = Int(secim) else { return }
        guard secimInt != 4 else { return }
        
        var urunKodu = ""
        var urunAdi = ""
        
        switch secim {
        case "1":
            urunKodu = "U01"
            urunAdi = "Ayakkabı"
        case "2":
            urunKodu = "U02"
            urunAdi = "Çanta"
        case "3":
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
        sonIslem = "\(urunAdi) stoğundan toplam \(toplamCikartilan) adet \(urunAdi) çıkarıldı."
        print(sonIslem!)
    }
}

func ara(_ isim: String) -> String? {
    switch isim {
    case "Ayakkabı":
        return "U01"
    case "Çanta":
        return "U02"
    case "Gözlük":
        return "U03"
    default:
        return nil
    }
}

func stokAra() {
    print("Aranacak ürün ismini girin: ", terminator: "")
    if let isim = readLine(), let urunKodu = ara(isim) {
        let stokMiktar = stoklar[urunKodu, default: 0]
        print("Stok Miktarı: \(stokMiktar) adet")
    } else {
        print("Ürün bulunamadı.")
    }
}

func stokListele() {
    for (urunKodu, stokMiktar) in stoklar {
        var urunAdi = ""
        
        switch urunKodu {
        case "U01":
            urunAdi = "Ayakkabı"
        case "U02":
            urunAdi = "Çanta"
        case "U03":
            urunAdi = "Gözlük"
        default:
            break
        }
        
        print("\(urunAdi) Stok Miktarı: \(stokMiktar) adet")
    }
}


func sonIslemGoster() {
    if let sonIslem {
        print("Son İşlem: \(sonIslem)")
    } else {
        print("Henüz bir işlem yapılmadı.")
    }
}

func menu() {
    var secim = 0
    
    repeat {
        print("---- DepoFLO v1.0 ----")
        print("1- Mal Ekle")
        print("2- Mal Çıkart")
        print("3- Stok Ara")
        print("4- Stok Listele")
        print("5- Son İşlem")
        print("6- Çık")
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
            stokAra()
        case 4:
            stokListele()
        case 5:
            sonIslemGoster()
        case 6:
            print("Program sonlandırıldı.")
        default:
            print("Geçersiz bir seçim yaptınız.")
        }
        
        print()
    } while secim != 6
}

menu()

