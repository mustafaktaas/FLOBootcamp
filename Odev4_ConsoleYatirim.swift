
//OdevYatirimSimulator
// 31-05-2023

import Foundation

func printString(_ str: String) {
    print(str)
}

func printInteger(_ num: Int) {
    print(num)
}

func printFloat(_ num: Float) {
    print(num)
}

func readInteger(withPrompt prompt: String) -> Int {
    print(prompt, terminator: "")
    if let input = readLine(), let number = Int(input) {
        return number
    } else {
        return 0
    }
}

func readFloat(withPrompt prompt: String) -> Float {
    print(prompt, terminator: "")
    if let input = readLine(), let number = Float(input) {
        return number
    } else {
        return 0.0
    }
}

func readString(withPrompt prompt: String) -> String {
    print(prompt, terminator: "")
    return readLine() ?? ""
}

func messageBox(_ message: String, messageType: Int) {
    let stars = String(repeating: "*", count: message.count + 4)
    print(stars)
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

func randomNumber(_ maxValue: Int) -> Int {
    return Int.random(in: 1...maxValue)
}

func gelirMi(_ value: Int) -> Bool {
    let randomValue = randomNumber(100)
    return randomValue < value
}

