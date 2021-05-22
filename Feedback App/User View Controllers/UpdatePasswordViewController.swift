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
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var updateIcon: UIImageView!
    @IBOutlet weak var updateView: UIView!
    var resetSuccess : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonBorders()
        setupLogoBorders()
        setupViewBorder()
    }
    
    func setupButtonBorders() {
        //Function that sets up the properties for UIButton Objects
        
        //Setup for Reset Button
        resetButton.layer.cornerRadius = 10.0
        resetButton.layer.masksToBounds = true
        resetButton.layer.borderColor = UIColor.black.cgColor
        resetButton.layer.borderWidth = 1.0
    }
    
    func setupLogoBorders() {
        //Function that sets up the properties for UIImageView Objects
        updateIcon.layer.masksToBounds = true
        updateIcon.layer.cornerRadius = updateIcon.bounds.width / 2
    }
    
    func setupViewBorder() {
        //Function that sets up the properties for UIView Objects
        updateView.layer.cornerRadius = 10.0
        updateView.layer.masksToBounds = true
        updateView.layer.borderColor = UIColor.black.cgColor
        updateView.layer.borderWidth = 1.0
    }
    
    @IBAction func resetButtonClicked(_ sender: Any) {
        //Function that updates the User's Password to the value inside newPassTextField
        let customerData = DatabaseHelper.inst.fetchData()
        var validInput: Bool = validateInput()
        
        if (newPassTextField.text == repeatNewPassTextField.text && validInput) {
            let dict = ["username" : String(SignInViewController.userIdentifier!), "password" : newPassTextField.text!] as [String : Any]
            DatabaseHelper.inst.resetPass(object: dict as! [String : String])
            newPassTextField.text = ""
            repeatNewPassTextField.text = ""
            resetSuccess = true
            print("Reset Password Success")
        }
        if (resetSuccess) {
            let sBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let accountPage = sBoard.instantiateViewController(identifier: "Account") as! AccountViewController
            present(accountPage, animated: true, completion: nil)
            newPassTextField.text = ""
            repeatNewPassTextField.text = ""
        }
    }
    
    func validateInput() -> Bool {
        //Function that checks if a user input in the newPassTextField and repeatPassTextField is acceptable. It returns true by default if any of the conditions are not met and returns false if any condition is met
        if (newPassTextField.text == "" || repeatNewPassTextField.text == "") {
            let alert = UIAlertController(title: "Error", message: "Text field for New Password, and repeat password must not be blank!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            newPassTextField.text = ""
            repeatNewPassTextField.text = ""
            return false
        }
        if (newPassTextField.text != repeatNewPassTextField.text) {
            let alert = UIAlertController(title: "Error", message: "New password and Repeat password text field not the same!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            newPassTextField.text = ""
            repeatNewPassTextField.text = ""
            return false
        }
        if (newPassTextField.text!.count < 4) {
            let alert = UIAlertController(title: "Error", message: "Less than 4 characters, minimum of 4 and maximum of 12 characters allowed in a password!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            newPassTextField.text = ""
            repeatNewPassTextField.text = ""
            return false
        }
        if (newPassTextField.text!.count > 12) {
            let alert = UIAlertController(title: "Error", message: "Too many characters, only 12 characters allowed in a password!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            newPassTextField.text = ""
            repeatNewPassTextField.text = ""
            return false
        }
        if (repeatNewPassTextField.text!.count < 4) {
            let alert = UIAlertController(title: "Error", message: "Less than 4 characters, minimum of 4 and maximum of 12 characters allowed in a password!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            newPassTextField.text = ""
            repeatNewPassTextField.text = ""
            return false
        }
        if (repeatNewPassTextField.text!.count > 12) {
            let alert = UIAlertController(title: "Error", message: "Too many characters, only 12 characters allowed in a password!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            newPassTextField.text = ""
            repeatNewPassTextField.text = ""
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
        //Function that toggles the Secure Text Entry property of the repeatNewPassTextField
        let passwordSecureState = repeatNewPassTextField.isSecureTextEntry
        if (passwordSecureState) {
            repeatNewPassTextField.isSecureTextEntry = false
        }
        else {
            repeatNewPassTextField.isSecureTextEntry = true
        }
    }
}
