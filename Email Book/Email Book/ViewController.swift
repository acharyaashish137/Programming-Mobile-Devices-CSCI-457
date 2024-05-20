

import UIKit



let BUTTON_SPACING = 15

let BUTTON_HEIGHT = 50

let DELETE_BUTTON_HEIGHT = BUTTON_HEIGHT / 3

let DELETE_BUTTON_WIDTH = 25

class ViewController: UIViewController {
    @IBOutlet weak var emailTextField:UITextField!
    
    @IBOutlet weak var emailList: UIScrollView!
    
    var emailAddresses: [String] = []
    
    var emailButtons: [UIButton] = []
    
    var deleteButtons: [UIButton] = []
    
    var ButtonArray : [UIButton] = []
    
    var InfoArray : [UIButton] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let fileURL = documentsURL.appendingPathComponent("emails.plist")
        
        
        
        if let savedEmails = NSArray(contentsOf: fileURL) as? [String] {
            
            emailAddresses = savedEmails
            
        }
        
        for email in emailAddresses {
            
            addEmailButton(email)
            
        }
        
        updateLayout()
        
    }
    
    @IBAction func addEmail(_ sender: AnyObject) {
        
        guard let email = emailTextField.text, !email.isEmpty else {
            
            return
            
        }
        
        emailAddresses.append(email)
        
        emailAddresses.sort()
        
        addEmailButton(email)
        
        updateLayout()
        
        emailTextField.text = nil
        
        saveEmailAddresses()
        
        
    }
    
    @IBAction func clearAll(sender: AnyObject) {
        
        ButtonArray.removeAll()
        
        InfoArray.removeAll()
        
        refreshList()
}
    func addEmailButton(_ email: String) {
        
        let emailButton = UIButton(type: .system)
        
        emailButton.setTitle(email, for: .normal)
        
        emailButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        
        emailButton.setTitleColor(.black, for: .normal)
        
        emailButton.contentHorizontalAlignment = .center // Set content alignment to center
        
        emailButton.addTarget(self, action: #selector(emailButtonTapped(_:)), for: .touchUpInside)
        
        emailButton.backgroundColor = UIColor.systemBlue
        
        emailButton.layer.borderColor = UIColor.black.cgColor
        
        emailButton.layer.borderWidth = 0.6
        
        emailButton.layer.cornerRadius = 12.0
        
        emailButtons.append(emailButton)
        
        emailList.addSubview(emailButton)
        
        let deleteButton = UIButton(type: .system)
        
        deleteButton.setTitle("X", for: .normal)
        
        deleteButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        deleteButton.setTitleColor(.black, for: .normal)
        
        deleteButton.contentHorizontalAlignment = .center // Set content alignment to center
        
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        
        deleteButton.backgroundColor = UIColor.systemRed
        
        deleteButton.layer.borderWidth = 0.3
        
        deleteButton.layer.cornerRadius = 5.0
        
        deleteButtons.append(deleteButton)
        
        emailList.addSubview(deleteButton)
        
    }
    
    func updateLayout() {
        
        let emailListWidth = emailList.frame.width
        
        let buttonWidth = emailListWidth - CGFloat(BUTTON_SPACING) * 2 - CGFloat(DELETE_BUTTON_WIDTH) - CGFloat(BUTTON_SPACING)
        
        var yOffset: CGFloat = 0
        
        
        
        for (index, button) in emailButtons.enumerated() {
            
            let x = CGFloat(BUTTON_SPACING)
            
            let y = yOffset
            
            
            
            button.frame = CGRect(x: x, y: y, width: buttonWidth, height: CGFloat(BUTTON_HEIGHT))
            
            deleteButtons[index].frame = CGRect(x: button.frame.maxX + CGFloat(BUTTON_SPACING), y: y + CGFloat(BUTTON_HEIGHT - DELETE_BUTTON_HEIGHT) / 2, width: CGFloat(DELETE_BUTTON_WIDTH), height: CGFloat(DELETE_BUTTON_HEIGHT))
            
            yOffset += CGFloat(BUTTON_HEIGHT + BUTTON_SPACING)
            
        }
        
        emailList.contentSize = CGSize(width: emailListWidth, height: yOffset)
        
    }
    
    @objc func emailButtonTapped(_ sender: UIButton) {
        
        guard let email = sender.titleLabel?.text, let url = URL(string: "mailto:\(email)") else {
            
            return
            
        }
        
        
        
        UIApplication.shared.open(url)
        
    }
    
    @objc func deleteButtonTapped(_ sender: UIButton) {
        
        let index = deleteButtons.firstIndex(of: sender)!
        
        
        
        emailAddresses.remove(at: index)
        
        emailButtons[index].removeFromSuperview()
        
        deleteButtons[index].removeFromSuperview()
        
        
        
        emailButtons.remove(at: index)
        
        deleteButtons.remove(at: index)
        
        
        
        updateLayout()
        
        
        
        saveEmailAddresses()
        
    }
    
    func saveEmailAddresses() {
        
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let fileURL = documentsURL.appendingPathComponent("emails.plist")
        
        
        
        (emailAddresses as NSArray).write(to: fileURL, atomically: true)
        
    }
    

    
    
    func refreshList() {
        let subviews = emailList.subviews as [UIView]
        for v in subviews {
            
            if let button = v as? UIButton {
                
                button.removeFromSuperview()
                
            }
            
            
            
        }
        
        InfoArray.removeAll()
        
        
        var buttonOffset: CGFloat = CGFloat(BUTTON_SPACING)
        
        for button: UIButton in ButtonArray {
            
            
            
            var buttonFrame: CGRect = button.frame
            
            buttonFrame.origin.x = CGFloat(BUTTON_SPACING)
            
            buttonFrame.origin.y = buttonOffset
            
            buttonFrame.size.width = 300
            
            buttonFrame.size.height = CGFloat(BUTTON_HEIGHT)
            
            button.frame = buttonFrame
            
            emailList.addSubview(button)
            
            let infoButton: UIButton = UIButton(type: .contactAdd)
            
            InfoArray.append(infoButton)
            
            buttonFrame = infoButton.frame
            
            
            buttonFrame.origin.x = 340
            
            
            buttonFrame.origin.y = buttonOffset + 20
            
            
            
            infoButton.frame = buttonFrame
            
            emailList.addSubview(infoButton)
            
            buttonOffset += CGFloat(BUTTON_HEIGHT + BUTTON_SPACING)
            
        }
        
    }
}
