import Foundation

// -------Otların birim fiyatlarını tutacak dictionary yapısı--------
var otFiyatlari: [String: Double] = [:]

// ------Otların tazeliğine göre fiyat düşüşünü tutacak dictionary yapısı-------
var tazelikEtkisi: [String: Double] = ["Kekik": -0.10, "Nane": -0.20, "Fesleğen": -0.10, "Reyhan": -0.25]

// -------Ot birim fiyatlarını kullanıcıdan alan kısım-----------
print("** Ot Master v1.0 ***")
print("Kg başı ot fiyatlarını giriniz:")

print("Kekik:", terminator: " ")
if let kekikFiyati = readLine(), let kekikFiyatiDouble = Double(kekikFiyati) {
    otFiyatlari["Kekik"] = kekikFiyatiDouble
}

print("Nane:", terminator: " ")
if let naneFiyati = readLine(), let naneFiyatiDouble = Double(naneFiyati) {
    otFiyatlari["Nane"] = naneFiyatiDouble
}

print("Fesleğen:", terminator: " ")
if let feslegenFiyati = readLine(), let feslegenFiyatiDouble = Double(feslegenFiyati) {
    otFiyatlari["Fesleğen"] = feslegenFiyatiDouble
}

print("Reyhan:", terminator: " ")
if let reyhanFiyati = readLine(), let reyhanFiyatiDouble = Double(reyhanFiyati) {
    otFiyatlari["Reyhan"] = reyhanFiyatiDouble
}

print("***********************")

