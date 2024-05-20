//Guessing Number Up to 5 times
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var guessNumber: UITextField!
    
    @IBOutlet weak var result: UILabel!

    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var reset: UIButton!
    
    var secretNumber = Int.random(in: 0...100)
    
    var secondsLeft = 25
    
    var numberOfGuesses = 0
    
    var timer: Timer = Timer()
    
    var timerCounting:Bool = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        reset.isEnabled = false
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(ViewController.countDown) , userInfo: nil, repeats: true)
        
    }
    
    
    @IBAction func guessButtonTapped(_ sender: Any) {
        
        if let guess = guessNumber.text, let number = Int(guess) {
            
            numberOfGuesses += 1
            
            if number == secretNumber {
                
                result.text = "Yes, it is \(secretNumber)"
                
            } else if number < secretNumber {
                
                result.text = "Guess higher!"
                
            } else {
                
                result.text = "Guess lower!"
                
            }
            
            if numberOfGuesses == 5 || secondsLeft == 0 {
                
                result.text = "Sorry, it was \(secretNumber)"
                
                reset.isEnabled = true
                
            }
            
        } else {
            
            result.text = "Please enter a number!"
            
        }
        
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        
        secretNumber = Int.random(in: 0...100)
        
        numberOfGuesses = 0
        
        secondsLeft = 30
        
        result.text = ""
        
        guessNumber.text = ""
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(ViewController.countDown) , userInfo: nil, repeats: true)
        
    }
    
    @IBAction func start() {
        timer.invalidate()
        
    }
    
    
    @objc func countDown() {
        secondsLeft -= 1
        timerLabel.text = String(secondsLeft)
      
        //TestLabel.text = String(RandImageNum)
    }
    
}

