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
    @IBOutlet weak var labelBackgroundImageView: UIImageView!
    var resetSuccess : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabelBorders()
        setupButtonBorders()
    }
    
    func setupButtonBorders() {
        //Setup for Reset Button
        resetButton.layer.cornerRadius = 10.0
        resetButton.layer.masksToBounds = true
        resetButton.layer.borderColor = UIColor.black.cgColor
        resetButton.layer.borderWidth = 1.0
    }
    
    func setupLabelBorders() {
        labelBackgroundImageView.layer.cornerRadius = 10.0
        labelBackgroundImageView.clipsToBounds = true
        labelBackgroundImageView.layer.borderColor = UIColor.black.cgColor
        labelBackgroundImageView.layer.borderWidth = 1.0
    }
    
    @IBAction func resetButtonClicked(_ sender: Any) {
        /*
         resetButtonClicked:
            Button object under ResetPasswordViewController
         */
        let customerData = DatabaseHelper.inst.fetchData()
        var validInput: Bool
        
        for c in customerData {
            validInput = validateInputs()
            if (c.username == usernameTextField.text && validInput) {
                //Checks for username entry in the Core Data and has a valid input from the user. Duplicate usernames handled during sign up
                if (newPassTextField.text == repeatPassTextField.text) {
                    //Checks if new password and repeat password have the same value
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
                print("No such username found")
            }
        }
        if (resetSuccess) {
            let sBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let signInPage = sBoard.instantiateViewController(identifier: "SignIn") as! SignInViewController
            present(signInPage, animated: true, completion: nil)
        }
    }
    
    
    func validateInputs() -> Bool {
        /*
         validateInputs:
            A method that checks if a user input in the usernameTextField, newPassTextField or repeatPassTextField is acceptable
         
         Return:
            Returns true by default if any of the conditions are not met
            Returns false if any condition is met
         */
        if (usernameTextField.text == "" || newPassTextField.text == "" ||
                repeatPassTextField.text == "") {
            //Checks if one or all text fields are left blank by user
            let alert = UIAlertController(title: "Error", message: "Text field for Username, New Password, and repeat password must not be blank!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            usernameTextField.text = ""
            newPassTextField.text = ""
            repeatPassTextField.text = ""
            return false
        }
        if (newPassTextField.text != repeatPassTextField.text) {
            //Checks if new password and repeat password have the same value
            let alert = UIAlertController(title: "Error", message: "New password and Repeat password text field not the same!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            usernameTextField.text = ""
            newPassTextField.text = ""
            repeatPassTextField.text = ""
            return false
        }
        if (newPassTextField.text!.count < 4) {
            //Checks if user input for new password is less than minimum 4
            let alert = UIAlertController(title: "Error", message: "Less than 4 characters, minimum of 4 and maximum of 12 characters allowed in a password!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            usernameTextField.text = ""
            newPassTextField.text = ""
            repeatPassTextField.text = ""
            return false
        }
        if (newPassTextField.text!.count > 12) {
            //Checks if user input for new password is more than maximum 12
            let alert = UIAlertController(title: "Error", message: "Too many characters, only 12 characters allowed in a password!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            usernameTextField.text = ""
            newPassTextField.text = ""
            repeatPassTextField.text = ""
            return false
        }
        if (repeatPassTextField.text!.count < 4) {
            //Checks if user input for repeat password is less than minimum 4
            let alert = UIAlertController(title: "Error", message: "Less than 4 characters, minimum of 4 and maximum of 12 characters allowed in a password!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            usernameTextField.text = ""
            newPassTextField.text = ""
            repeatPassTextField.text = ""
            return false
        }
        if (repeatPassTextField.text!.count > 12) {
            //Checks if user input for repeat password is more than maximum 12
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
        let passwordSecureState = newPassTextField.isSecureTextEntry
        if (passwordSecureState) {
            newPassTextField.isSecureTextEntry = false
        }
        else {
            newPassTextField.isSecureTextEntry = true
        }
    }
    
    @IBAction func showRepeatPassword(_ sender: Any) {
        let passwordSecureState = repeatPassTextField.isSecureTextEntry
        if (passwordSecureState) {
            repeatPassTextField.isSecureTextEntry = false
        }
        else {
            repeatPassTextField.isSecureTextEntry = true
        }
    }
}
