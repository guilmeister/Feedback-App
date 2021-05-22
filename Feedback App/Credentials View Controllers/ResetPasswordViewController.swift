//
//  ResetPasswordViewController.swift
//  Feedback App
//
//  Created by Edward Guilllermo on 4/26/21.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var newPassTextField: UITextField!
    @IBOutlet weak var repeatPassTextField: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var resetLogo: UIImageView!
    @IBOutlet weak var resetView: UIView!
    var resetSuccess : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonBorders()
        setupLogoBorders()
        setupViewBorder()
    }
    
    func setupButtonBorders() {
        //Function that sets up the properties for UIButton Objects
        resetButton.layer.cornerRadius = 10.0
        resetButton.layer.masksToBounds = true
        resetButton.layer.borderColor = UIColor.black.cgColor
        resetButton.layer.borderWidth = 1.0
    }
    
    func setupLogoBorders() {
        //Function that sets up the properties for UIImageView Objects
        resetLogo.layer.masksToBounds = true
        resetLogo.layer.cornerRadius = resetLogo.bounds.width / 2
    }
    
    func setupViewBorder() {
        //Function that sets up the properties for UIView Objects
        resetView.layer.cornerRadius = 10.0
        resetView.layer.masksToBounds = true
        resetView.layer.borderColor = UIColor.black.cgColor
        resetView.layer.borderWidth = 1.0
    }
    
    @IBAction func resetButtonClicked(_ sender: Any) {
         //Function that takes in Username, New Password, and Repeat New Password from their respective text fields and stores the new password inside Core Data after validation
        let customerData = DatabaseHelper.inst.fetchData()
        var validInput: Bool
        
        for c in customerData {
            validInput = validateInputs()
            if (c.username == usernameTextField.text && validInput) {
                if (newPassTextField.text == repeatPassTextField.text) {
                    let dict = ["username" : usernameTextField.text, "password" : newPassTextField.text]
                    DatabaseHelper.inst.resetPass(object: dict as! [String : String])
                    usernameTextField.text = ""
                    newPassTextField.text = ""
                    repeatPassTextField.text = ""
                    resetSuccess = true
                    break
                }
            }
            else {
                let alert = UIAlertController(title: "Error", message: "No such Username found!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        if (resetSuccess) {
            let sBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let signInPage = sBoard.instantiateViewController(identifier: "SignIn") as! SignInViewController
            present(signInPage, animated: true, completion: nil)
        }
    }
    
    
    func validateInputs() -> Bool {
         //Function that checks if a user input in the usernameTextField, newPassTextField or repeatPassTextField is acceptable. It returns true by default if any of the conditions are not met and returns false if any condition is met
        if (usernameTextField.text == "" || newPassTextField.text == "" ||
                repeatPassTextField.text == "") {
            let alert = UIAlertController(title: "Error", message: "Text field for Username, New Password, and repeat password must not be blank!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            usernameTextField.text = ""
            newPassTextField.text = ""
            repeatPassTextField.text = ""
            return false
        }
        if (newPassTextField.text != repeatPassTextField.text) {
            let alert = UIAlertController(title: "Error", message: "New password and Repeat password text field not the same!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            usernameTextField.text = ""
            newPassTextField.text = ""
            repeatPassTextField.text = ""
            return false
        }
        if (newPassTextField.text!.count < 4) {
            let alert = UIAlertController(title: "Error", message: "Less than 4 characters, minimum of 4 and maximum of 12 characters allowed in a password!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            usernameTextField.text = ""
            newPassTextField.text = ""
            repeatPassTextField.text = ""
            return false
        }
        if (newPassTextField.text!.count > 12) {
            let alert = UIAlertController(title: "Error", message: "Too many characters, only 12 characters allowed in a password!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            usernameTextField.text = ""
            newPassTextField.text = ""
            repeatPassTextField.text = ""
            return false
        }
        if (repeatPassTextField.text!.count < 4) {
            let alert = UIAlertController(title: "Error", message: "Less than 4 characters, minimum of 4 and maximum of 12 characters allowed in a password!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            usernameTextField.text = ""
            newPassTextField.text = ""
            repeatPassTextField.text = ""
            return false
        }
        if (repeatPassTextField.text!.count > 12) {
            let alert = UIAlertController(title: "Error", message: "Too many characters, only 12 characters allowed in a password!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            usernameTextField.text = ""
            newPassTextField.text = ""
            repeatPassTextField.text = ""
            return false
        }
        return true
    }
    
    @IBAction func showNewPassword(_ sender: Any) {
        //Function that toggles the Secure Text Entry property of the newPassTextField
        let passwordSecureState = newPassTextField.isSecureTextEntry
        if (passwordSecureState) {
            newPassTextField.isSecureTextEntry = false
        }
        else {
            newPassTextField.isSecureTextEntry = true
        }
    }
    
    @IBAction func showRepeatPassword(_ sender: Any) {
        //Function that toggles the Secure Text Entry property of the repeatPassTextField
        let passwordSecureState = repeatPassTextField.isSecureTextEntry
        if (passwordSecureState) {
            repeatPassTextField.isSecureTextEntry = false
        }
        else {
            repeatPassTextField.isSecureTextEntry = true
        }
    }
}
