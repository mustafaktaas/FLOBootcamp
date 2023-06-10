//
//  ViewController.swift
//  YatirimMasterUI
//
//  Created by Mustafa Aktas on 3.06.2023.
//

import UIKit

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

struct Investment {
    let name: String
    let changeProbability: Double
    let changePercentage: Double
}

let investments: [Investment] = [
    Investment(name: "Dolar", changeProbability: 50, changePercentage: 20),
    Investment(name: "Euro", changeProbability: 60, changePercentage: 10),
    Investment(name: "Altın", changeProbability: 40, changePercentage: 15),
    Investment(name: "Gümüş", changeProbability: 30, changePercentage: 20),
    Investment(name: "Faiz", changeProbability: 100, changePercentage: 15),
    Investment(name: "BTC", changeProbability: 20, changePercentage: 25)
]


class ViewController: UIViewController {

    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var riskAppetiateTextField: UITextField!
    @IBOutlet weak var monthlyIncomeTextField: UITextField!
    @IBOutlet weak var invesmentAmountTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calculateButton(_ sender: UIButton) {
    }
    
    func randomNumber(_ max: Int) -> Int {
        let randomNum = Int.random(in: 1...max)
        return randomNum
    }

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
    
    func printInvestment(investmentAmount: Double, riskLevel: Int, exchangeRates: (Double, Double, Double, Double, Double, Double)) {
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
        
        print("\nRisk iştahı ve Kura göre hangi yatırım aracından ne kadar aldığınız:")
        print("*******")
        print("Dolar : \(dolarAmount) $")
        print("Euro : \(euroAmount) €")
        print("Altın : \(altinAmount) GR")
        print("Gümüş : \(gumusAmount) GR")
        print("Faiz : \(faizAmount) TL")
        print("Bitcoin : \(btcAmount) BTC")
        print("*******")
    }
    
    func calculateProfitLoss(amount: Double, investment: Investment, exchangeRate: Double) -> (Double, Double) {
        let random = randomNumber(100)
        let isIncrease = Double(random) < investment.changeProbability
        let changePercentage = isIncrease ? investment.changePercentage : -investment.changePercentage
        let profitLoss = amount * changePercentage / 100
        let totalAmount = amount + profitLoss * exchangeRate
        return (profitLoss, totalAmount)
    }

    func calculateInvestment(investmentAmount: Double, riskLevel: Int, exchangeRates: (Double, Double, Double, Double, Double, Double)) {
        guard let riskAppetite = getRiskAppetite(riskLevel: riskLevel) else {
            print("Invalid risk level.")
            return
        }
        
        let (dolarRate, euroRate, altinRate, gumusRate, faizRate, btcRate) = exchangeRates
        
        var totalProfitLoss: Double = 0
        var totalAmount: Double = 0
        
        print("\n Hangi yatırım aracından ne kadar kar/zarar ettiğiniz:")
        print("-------------------------------------------------------------")
        
        for investment in investments {
            let amount: Double
            let exchangeRate: Double
            
            switch investment.name {
            case "Dolar":
                amount = investmentAmount * (Double(riskAppetite.dolar) / 100)
                exchangeRate = dolarRate
            case "Euro":
                amount = investmentAmount * (Double(riskAppetite.euro) / 100)
                exchangeRate = euroRate
            case "Altın":
                amount = investmentAmount * (Double(riskAppetite.altin) / 100)
                exchangeRate = altinRate
            case "Gümüş":
                amount = investmentAmount * (Double(riskAppetite.gumus) / 100)
                exchangeRate = gumusRate
            case "Faiz":
                amount = investmentAmount * (Double(riskAppetite.faiz) / 100)
                exchangeRate = faizRate
            case "BTC":
                amount = investmentAmount * (Double(riskAppetite.btc) / 100)
                exchangeRate = btcRate
            default:
                amount = 0
                exchangeRate = 1
            }
            
            let (profitLoss, newAmount) = calculateProfitLoss(amount: amount, investment: investment, exchangeRate: exchangeRate)
            totalProfitLoss += profitLoss
            totalAmount += newAmount
            
            let changeType = profitLoss >= 0 ? "Kar" : "Zarar"
            let changePercentage = profitLoss >= 0 ? investment.changePercentage : -investment.changePercentage
            
            print("\(investment.name) - Değişim Oranı: \(investment.changePercentage)%")
            print("Miktar: \(amount) TL")
            print("Gelir/Zarar: \(profitLoss) TL (\(changeType): \(changePercentage)%)")
            print("-------------------------------------------------------------")
        }
        
        print("\nToplam Gelir/Zarar: \(totalProfitLoss) TL")
    }

}

