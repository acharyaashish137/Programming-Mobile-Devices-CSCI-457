import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var uiResult: UITextField!
    
    var varNumber1=0
    var varNumber2=0
    var varNumber3=0
    var varResult=0
    var varOperator = "+"


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func button1(Sender :UIButton){
        uiResult.text=uiResult.text! + "1"
    }
    @IBAction func button2(Sender :UIButton){
        uiResult.text=uiResult.text! + "2"

    }
    @IBAction func button3(Sender :UIButton){
        uiResult.text=uiResult.text! + "3"

    }
    @IBAction func button0(Sender :UIButton){
        uiResult.text=uiResult.text! + "0"

    }
    @IBAction func buttonPlus(Sender :UIButton){
        varOperator = "+"
        varNumber1 = Int(uiResult.text!)!
        clearText()
    }
    @IBAction func buttonMinus(Sender :UIButton){
        varOperator = "-"
        varNumber1 = Int(uiResult.text!)!
        clearText()
    }
    
    @IBAction func buttonEqual(Sender :UIButton){
        varNumber2 = Int(uiResult.text!)!
        
        switch varOperator {
            
        case "+":
            varResult = varNumber1 + varNumber2
            uiResult.text = String( varResult )
            
        case "-":
            varResult = varNumber1 - varNumber2
            uiResult.text = String( varResult )
            
        default:
            uiResult.text = "Error"

            
            
        }
        
    }
    
    @IBAction func buttonClear(Sender :UIButton){
      clearText()
    }
    func clearText(){
        uiResult.text=""

        
    }

}

