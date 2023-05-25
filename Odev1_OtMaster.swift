import Foundation

// -------Otların birim fiyatlarını tutacak dictionary yapısı--------
var otBirimFiyat: [String: Double] = [:]

// ------Otların tazeliğine göre fiyat düşüşünü tutacak dictionary yapısı-------
var otTazelikEtkisi: [String: Double] = ["Kekik": -0.10, "Nane": -0.20, "Fesleğen": -0.10, "Reyhan": -0.25]

// -------Ot birim fiyatlarını kullanıcıdan alan kısım-----------
print("** Ot Master v1.0 ***")
print("Kg başı ot fiyatlarını giriniz:")

print("Kekik:", terminator: " ")
if let kekikFiyati = readLine(), let kekikFiyatiDouble = Double(kekikFiyati) {
    otBirimFiyat["Kekik"] = kekikFiyatiDouble
}

print("Nane:", terminator: " ")
if let naneFiyati = readLine(), let naneFiyatiDouble = Double(naneFiyati) {
    otBirimFiyat["Nane"] = naneFiyatiDouble
}

print("Fesleğen:", terminator: " ")
if let feslegenFiyati = readLine(), let feslegenFiyatiDouble = Double(feslegenFiyati) {
    otBirimFiyat["Fesleğen"] = feslegenFiyatiDouble
}

print("Reyhan:", terminator: " ")
if let reyhanFiyati = readLine(), let reyhanFiyatiDouble = Double(reyhanFiyati) {
    otBirimFiyat["Reyhan"] = reyhanFiyatiDouble
}

print("***********************")

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

// --------Kullanıcıdan bilgi alma------------
print("Tür:", terminator: " ")
if let otAdi = readLine(), let birimFiyat = otBirimFiyat(otAdi) {
    print("\(otAdi) miktar (kg) :", terminator: " ")
    if let miktarStr = readLine(), let miktar = Double(miktarStr) {
        print("Taze mi? (1=taze,0=taze degil):", terminator: " ")
        if let tazeMiStr = readLine(), let tazeMi = Int(tazeMiStr) {
            let tutar = birimFiyat * miktar
            let tazelikEtki = otTazelikEtkisi(otAdi, tazeMi == 0)
            let toplamTutar = tutar + (tutar * tazelikEtki)
            let kdv = toplamTutar * 0.18
            let genelToplam = toplamTutar + kdv

            print("İşlem tutar: \(tutar) TL")
            print("Tazelik etkisi: \(tazelikEtki)")
            print("Tutar: \(toplamTutar) TL")
            print("KDV(%18): \(kdv) TL")
            print("**********************")
            print("Fatura:")
            print("---------------------------------------")
            print("OT A.Ş.")
            print("* \(otAdi): \(miktar)kg * \(birimFiyat) TL = \(tutar)")
            print(tazeMi == 0 ? "Taze değil." : "Taze.")
            print("KDV (%18) : \(kdv) TL")
            print("Genel Toplam: \(genelToplam) TL")
        }
    }
}
print("!!!")
