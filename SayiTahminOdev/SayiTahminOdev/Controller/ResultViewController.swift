import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var longResultLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var guessedCorrectly: Bool = false
    var totalAttempts: Int = 0
    var randomNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func playAgainButton(_ sender: UIButton) {
        if let guessViewController = storyboard?.instantiateViewController(withIdentifier: "GuessPage") as? GuessViewController {
            DispatchQueue.main.async {
                self.view.window?.rootViewController = guessViewController
            }
        }
    }
    
    func updateUI() {
        if guessedCorrectly {
            resultLabel.text = "KAZANDIN!"
            longResultLabel.text = "Toplam \(totalAttempts) deneme yaptın."
            imageView.image = UIImage(named: "basarili")
        } else {
            resultLabel.text = "KAYBETTİN!"
            longResultLabel.text = "Tüm haklarını tamamladın.\nDoğru cevap \(randomNumber) idi."
            imageView.image = UIImage(named: "basarisiz")
        }
    }
}

