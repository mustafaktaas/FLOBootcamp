import UIKit

class GuessViewController: UIViewController {
    @IBOutlet weak var uporDownLabel: UILabel!
    @IBOutlet weak var newNumberLabel: UILabel!
    @IBOutlet weak var getNumberTextField: UITextField!
    @IBOutlet weak var remainderRightLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var randomNumber: Int = 0
    var remainingAttempts: Int = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateRandomNumber()
        updateremainderRightLabel()
    }
    
    @IBAction func GuessButton(_ sender: UIButton) {
        guard let guessedNumberText = getNumberTextField.text, let guessedNumber = Int(guessedNumberText) else {
            return
        }
        
        if guessedNumber == randomNumber {
            showResult(guessedCorrectly: true)
        } else {
            remainingAttempts -= 1
            
            if remainingAttempts == 0 {
                showResult(guessedCorrectly: false)
            } else {
                if guessedNumber < randomNumber {
                    uporDownLabel.text = "ARTIR"
                } else {
                    uporDownLabel.text = "AZALT"
                }
                
                newNumberLabel.text = "Tahmin için yeni bir sayı yaz"
                imageView.image = UIImage(named: "yanlis")
                getNumberTextField.text = ""
                updateremainderRightLabel()
            }
        }
    }
    
    func generateRandomNumber() {
        randomNumber = Int.random(in: 1...10)
    }
    
    func updateremainderRightLabel() {
        remainderRightLabel.text = "\(remainingAttempts)"
    }
    
    func showResult(guessedCorrectly: Bool) {
        if let resultViewController = storyboard?.instantiateViewController(withIdentifier: "ResultPage") as? ResultViewController {
            resultViewController.guessedCorrectly = guessedCorrectly
            resultViewController.totalAttempts = 6 - remainingAttempts
            resultViewController.randomNumber = randomNumber
            
            DispatchQueue.main.async {
                self.view.window?.rootViewController = resultViewController
            }
        }
    }
}

