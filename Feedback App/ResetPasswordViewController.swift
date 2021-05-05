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
    var resetSuccess : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            print("Text field for Username, New Password, and repeat password must not be blank")
            usernameTextField.text = ""
            newPassTextField.text = ""
            repeatPassTextField.text = ""
            return false
        }
        if (newPassTextField.text != repeatPassTextField.text) {
            //Checks if new password and repeat password have the same value
            print("New password and Repeat password text field not the same")
            usernameTextField.text = ""
            newPassTextField.text = ""
            repeatPassTextField.text = ""
            return false
        }
        if (newPassTextField.text!.count < 4) {
            //Checks if user input for new password is less than minimum 4
            print("Less than 4 characters, minimum of 4 and maximum of 12 characters allowed in a password")
            usernameTextField.text = ""
            newPassTextField.text = ""
            repeatPassTextField.text = ""
            return false
        }
        if (newPassTextField.text!.count > 12) {
            //Checks if user input for new password is more than maximum 12
            print("Too many characters, only 12 characters allowed in a password")
            usernameTextField.text = ""
            newPassTextField.text = ""
            repeatPassTextField.text = ""
            return false
        }
        if (repeatPassTextField.text!.count < 4) {
            //Checks if user input for repeat password is less than minimum 4
            print("Less than 4 characters, minimum of 4 and maximum of 12 characters allowed in a password")
            usernameTextField.text = ""
            newPassTextField.text = ""
            repeatPassTextField.text = ""
            return false
        }
        if (repeatPassTextField.text!.count > 12) {
            //Checks if user input for repeat password is more than maximum 12
            print("Too many characters, only 12 characters allowed in a password")
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
