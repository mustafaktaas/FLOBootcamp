
//OdevYatirimSimulator
// 31-05-2023

import Foundation

func printString(_ value: String) {
    print(value)
}

func printInteger(_ value: Int) {
    print(value)
}

func printFloat(_ value: Float) {
    print(value)
}

func readInteger(_ prompt: String) -> Int {
    print(prompt, terminator: "")
    if let input = readLine(), let value = Int(input) {
        return value
    } else {
        return 0
    }
}

func readFloat(_ prompt: String) -> Float {
    print(prompt, terminator: "")
    if let input = readLine(), let value = Float(input) {
        return value
    } else {
        return 0.0
    }
}

func readString(_ prompt: String) -> String {
    print(prompt, terminator: "")
    return readLine() ?? ""
}

func messageBox(_ message: String, messageType: String) {
    let stars = String(repeating: "*", count: message.count + 4)
    print(stars)
    print("* \(messageType) *")
    print("* \(message) *")
    print(stars)
}

func greetings() {
    print("\nHoşgeldiniz...")
    print("Yatırım Ustası v1.0 by FLO Bootcamp")
}

func byebye() {
    print("\nİyi günler....")
    print("Yatırım Ustası v1.0 by FLO Bootcamp")
}

func randomNumber(_ max: Int) -> Int {
    let randomNum = Int.random(in: 1...max)
    return randomNum
}

func gelirMi() -> Bool {
    let randomNum = randomNumber(100)
    return randomNum < 100
}

struct RiskAppetite {
    let riskLevel: Int
    var dolar: Int
    var euro: Int
    var altin: Int
    var gumus: Int
    var faiz: Int
    var btc: Int
}

let riskAppetiteTable: [RiskAppetite] = [
    RiskAppetite(riskLevel: 1, dolar: 0, euro: 0, altin: 0, gumus: 0, faiz: 100, btc: 0),
    RiskAppetite(riskLevel: 2, dolar: 30, euro: 30, altin: 20, gumus: 0, faiz: 20, btc: 0),
    RiskAppetite(riskLevel: 3, dolar: 50, euro: 0, altin: 10, gumus: 30, faiz: 0, btc: 10),
    RiskAppetite(riskLevel: 4, dolar: 30, euro: 0, altin: 0, gumus: 10, faiz: 0, btc: 60),
    RiskAppetite(riskLevel: 5, dolar: 10, euro: 0, altin: 0, gumus: 20, faiz: 0, btc: 70)
]

func getRiskAppetite(riskLevel: Int) -> RiskAppetite? {
    return riskAppetiteTable.first { $0.riskLevel == riskLevel }
}

func getRiskGroup(riskAppetite: Int, incomeToInvestmentRatio: Double, age: Int) -> Int {
    guard let riskAppetite = getRiskAppetite(riskLevel: riskAppetite) else {
        return riskAppetite
    }
    
    switch (incomeToInvestmentRatio, age) {
    case let (ratio, _) where ratio > 5:
        return riskAppetite.riskLevel
    case let (ratio, age) where ratio >= 1 && ratio <= 5 && age > 60:
        return riskAppetite.riskLevel - 1
    case let (ratio, age) where ratio >= 0.5 && ratio < 1 && age < 40:
        return riskAppetite.riskLevel
    /*
    case let (ratio, age) where ratio >= 0.5 && ratio < 1 && age > 40 && age <= 50:
        if riskAppetite.btc > 0 {
            // Eğer bitcoin yatırımı varsa
            let btcAllocation = riskAppetite.btc / 5
            // Bitcoin yatırımına düşen yüzdeyi diğer 5 yatırım tipine eşit şekilde böl
            return RiskAppetite(riskLevel: riskAppetite.riskLevel,
                                dolar: riskAppetite.dolar + btcAllocation,
                                euro: riskAppetite.euro + btcAllocation,
                                altin: riskAppetite.altin + btcAllocation,
                                gumus: riskAppetite.gumus + btcAllocation,
                                faiz: riskAppetite.faiz + btcAllocation,
                                btc: 0)
        }
        // Bitcoin yatırımı yoksa aynı risk iştahını döndür
        return riskAppetite
     */
    case let (ratio, age) where ratio >= 0.5 && ratio < 1 && age > 50:
        return riskAppetite.riskLevel - 1
    case let (ratio, age) where ratio >= 0.1 && ratio < 0.5 && age < 30:
        return riskAppetite.riskLevel
    case let (ratio, age) where ratio >= 0.1 && ratio < 0.5 && age > 30:
        return riskAppetite.riskLevel - 1
    case let (ratio, _) where ratio < 0.1:
        if riskAppetite.riskLevel == 5 {
            return 4
        } else if riskAppetite.riskLevel == 4 {
            return 2
        } else {
            return 1
        }
    default:
        return riskAppetite.riskLevel
    }
}

func calculateInvestment(investmentAmount: Double, riskLevel: Int, exchangeRates: (Double, Double, Double, Double, Double, Double), firstName: String, lastName: String, age: Int, monthlyIncome: Double) {
    guard let riskAppetite = getRiskAppetite(riskLevel: riskLevel) else {
        print("Invalid risk level.")
        return
    }
    
    let (dolarRate, euroRate, altinRate, gumusRate, faizRate, btcRate) = exchangeRates
    
    let dolarAmount = investmentAmount / dolarRate * (Double(riskAppetite.dolar) / 100)
    let euroAmount = investmentAmount / euroRate * (Double(riskAppetite.euro) / 100)
    let altinAmount = investmentAmount / altinRate * (Double(riskAppetite.altin) / 100)
    let gumusAmount = investmentAmount / gumusRate * (Double(riskAppetite.gumus) / 100)
    let faizAmount = investmentAmount / faizRate * (Double(riskAppetite.faiz) / 100)
    let btcAmount = investmentAmount / btcRate * (Double(riskAppetite.btc) / 100)
    
    print("Risk iştahı ve Kura göre hangi yatırım aracından ne kadar aldığımız:")
    print("***************************************************************")
    print("Dolar : \(dolarAmount) $")
    print("Euro : \(euroAmount) €")
    print("Altın : \(altinAmount) GR")
    print("Gümüş : \(gumusAmount) GR")
    print("Faiz : \(faizAmount) TL")
    print("Bitcoin : \(btcAmount) BTC")
    print("***************************************************************")
}

func main() {
    greetings()
    
    let firstName = readString("Adınızı girin: ")
    let lastName = readString("Soyadınızı girin: ")
    let age = readInteger("Yaşınızı girin: ")
    let riskAppetite = readInteger("Risk iştahınızı girin (1-5 arası): ")
    let monthlyIncome = readFloat("Aylık gelirinizi girin: ")
    let investmentAmount = readFloat("Yatırım miktarınızı girin: ")
    
    let riskLevel = getRiskGroup(riskAppetite: riskAppetite, incomeToInvestmentRatio: Double(investmentAmount) / Double(monthlyIncome), age: age)
    
    print("Güncel risk iştahınız: \(riskLevel)")
    
    let exchangeRates: (Double, Double, Double, Double, Double, Double) = (8.3, 10.1, 510, 7.5, 1000, 1)
    
    calculateInvestment(investmentAmount: Double(investmentAmount), riskLevel: riskLevel, exchangeRates: exchangeRates, firstName: firstName, lastName: lastName, age: age, monthlyIncome: Double(monthlyIncome))
    
    byebye()
}

main()
