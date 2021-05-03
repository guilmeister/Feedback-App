//
//  SignUpViewController.swift
//  Feedback App
//
//  Created by Edward Guilllermo on 4/25/21.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        /*
         signUpButtonClicked:
            Button object under SignUpViewController
         */
        let customerData = DatabaseHelper.inst.fetchData()
        var isUnique : Bool
        var index = 0
        
        for c in customerData {
            isUnique = validateInputs(customerData: customerData)
            if (index == customerData.count - 1 && isUnique) {
                //Checks every username entry in the Core Data and has a valid input from the user
                let dict = ["username" : userTextField.text, "password" : passwordTextField.text]
                DatabaseHelper.inst.signUpButtonClicked(object: dict as! [String : String])
                userTextField.text = ""
                passwordTextField.text = ""
            }
            index += 1
        }
    }
    
    func validateInputs(customerData: [Customer]) -> Bool {
        /*
         validateInputs:
            A method that checks if a user input in the userTextField or passwordTextField is acceptable
         
         Parameters:
            customerData - An array of Customer objects fetched from Core Data Store inside DatabaseHelper.swift
         
         Return:
            Returns true by default if any of the conditions are not met
            Returns false if any condition is met
         */
        for c in customerData {
            if (userTextField.text == "" || passwordTextField.text == "") {
                //Checks if either text fields are left blank by user
                print("Text field for Username and Password must not be blank")
                userTextField.text = ""
                passwordTextField.text = ""
                return false
            }
            if (c.username == userTextField.text) {
                //Checks if user input for username exists in the Core Data
                print("Username taken, please input another username")
                userTextField.text = ""
                passwordTextField.text = ""
                return false
            }
            if (userTextField.text!.count < 4) {
                //Checks if user input for username is less than minimum 4
                print("Less than 4 characters, minimum of 4 and maximum of 12 characters allowed in a username")
                userTextField.text = ""
                passwordTextField.text = ""
                return false
            }
            if (userTextField.text!.count > 12) {
                //Checks if user input for username is more than maximum 12
                print("Too many characters, only 12 characters allowed in a username")
                userTextField.text = ""
                passwordTextField.text = ""
                return false
            }
            if (passwordTextField.text!.count < 4) {
                //Checks if user input for password is less than minimum 4
                print("Less than 4 characters, minimum of 4 and maximum of 12 characters allowed in a password")
                userTextField.text = ""
                passwordTextField.text = ""
                return false
            }
            if (passwordTextField.text!.count > 12) {
                //Checks if user input for password is more than maximum 12
                print("Too many characters, only 12 character allowed in a password")
                userTextField.text = ""
                passwordTextField.text = ""
                return false
            }
        }
        return true
    }
}
