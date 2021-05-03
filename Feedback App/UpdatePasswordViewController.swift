//
//  UpdatePasswordViewController.swift
//  Feedback App
//
//  Created by Edward Guilllermo on 5/3/21.
//

import UIKit

class UpdatePasswordViewController: UIViewController {

    @IBOutlet weak var newPassTextField: UITextField!
    @IBOutlet weak var repeatNewPassTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func resetButtonClicked(_ sender: Any) {
        let customerData = DatabaseHelper.inst.fetchData()
        var validInput: Bool = validateInput()
        
        if (newPassTextField.text == repeatNewPassTextField.text && validInput) {
            let dict = ["username" : String(SignInViewController.userIdentifier!), "password" : newPassTextField.text!] as [String : Any]
            DatabaseHelper.inst.resetPass(object: dict as! [String : String])
        }
    }
    
    func validateInput() -> Bool {
        if (newPassTextField.text == "" || repeatNewPassTextField.text == "") {
            print("Text field for New Password, and repeat password must not be blank")
            newPassTextField.text = ""
            repeatNewPassTextField.text = ""
            return false
        }
        if (newPassTextField.text != repeatNewPassTextField.text) {
            print("New password and Repeat password text field not the same")
            newPassTextField.text = ""
            repeatNewPassTextField.text = ""
            return false
        }
        if (newPassTextField.text!.count < 4) {
            print("Less than 4 characters, minimum of 4 and maximum of 12 characters allowed in a password")
            newPassTextField.text = ""
            repeatNewPassTextField.text = ""
            return false
        }
        if (newPassTextField.text!.count > 12) {
            print("Too many characters, only 12 characters allowed in a password")
            newPassTextField.text = ""
            repeatNewPassTextField.text = ""
            return false
        }
        if (repeatNewPassTextField.text!.count < 4) {
            print("Less than 4 characters, minimum of 4 and maximum of 12 characters allowed in a password")
            newPassTextField.text = ""
            repeatNewPassTextField.text = ""
            return false
        }
        if (repeatNewPassTextField.text!.count > 12) {
            print("Too many characters, only 12 characters allowed in a password")
            newPassTextField.text = ""
            repeatNewPassTextField.text = ""
            return false
        }
        return true
    }
}
