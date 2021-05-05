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
            Interface Builder Method that takes in Username and Password from respective text fields and stores it inside Core Data Store after validation
         */
        let customerData = DatabaseHelper.inst.fetchData()
        var isUnique : Bool
        var signUpSuccess : Bool = false
        var index = 0
        
        if (customerData.isEmpty) {
            //Checks if customerData array is empty, condition met during new phone simulators or deleting all data on current phone simulator
            isUnique = validateInputs(customerData: customerData)
            if (isUnique) {
                //Checks for validity from validateInputs method and saves the data to the Core Data Store if valid
                let dict = ["username" : userTextField.text, "password" : passwordTextField.text]
                DatabaseHelper.inst.signUpButtonClicked(object: dict as! [String : String])
                userTextField.text = ""
                passwordTextField.text = ""
                signUpSuccess = true
            }
            if (signUpSuccess) {
                //Instantiate the SignInViewController after every successful sign up
                let sBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let signInPage = sBoard.instantiateViewController(identifier: "SignIn") as! SignInViewController
                present(signInPage, animated: true, completion: nil)
            }
        }
        
        for c in customerData {
            isUnique = validateInputs(customerData: customerData)
            if (index == customerData.count - 1 && isUnique) {
                //Checks every username entry in the Core Data and has a valid input from the user
                let dict = ["username" : userTextField.text, "password" : passwordTextField.text]
                DatabaseHelper.inst.signUpButtonClicked(object: dict as! [String : String])
                userTextField.text = ""
                passwordTextField.text = ""
                signUpSuccess = true
                break
            }
            index += 1
        }
        if (signUpSuccess) {
            let sBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let signInPage = sBoard.instantiateViewController(identifier: "SignIn") as! SignInViewController
            present(signInPage, animated: true, completion: nil)
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
            if (userTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty || passwordTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty) {
                //Checks if either text fields are left blank by user including whitespaces
                let alert = UIAlertController(title: "Error", message: "Text field for Username and Password must not be blank!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                userTextField.text = ""
                passwordTextField.text = ""
                return false
            }
            if (c.username == userTextField.text) {
                //Checks if user input for username exists in the Core Data
                let alert = UIAlertController(title: "Error", message: "Username taken, please input another username!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                userTextField.text = ""
                passwordTextField.text = ""
                return false
            }
            if (userTextField.text!.count < 4) {
                //Checks if user input for username is less than minimum 4
                let alert = UIAlertController(title: "Error", message: "Less than 4 characters, minimum of 4 and maximum of 12 characters allowed in a username!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                userTextField.text = ""
                passwordTextField.text = ""
                return false
            }
            if (userTextField.text!.count > 12) {
                //Checks if user input for username is more than maximum 12
                let alert = UIAlertController(title: "Error", message: "Too many characters, only 12 characters allowed in a username!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                userTextField.text = ""
                passwordTextField.text = ""
                return false
            }
            if (passwordTextField.text!.count < 4) {
                //Checks if user input for password is less than minimum 4
                let alert = UIAlertController(title: "Error", message: "Less than 4 characters, minimum of 4 and maximum of 12 characters allowed in a password!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                userTextField.text = ""
                passwordTextField.text = ""
                return false
            }
            if (passwordTextField.text!.count > 12) {
                //Checks if user input for password is more than maximum 12
                let alert = UIAlertController(title: "Error", message: "Too many characters, only 12 character allowed in a password!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                userTextField.text = ""
                passwordTextField.text = ""
                return false
            }
        }
        return true
    }
    
    
    @IBAction func showPassword(_ sender: Any) {
        let passwordSecureState = passwordTextField.isSecureTextEntry
        if (passwordSecureState) {
            passwordTextField.isSecureTextEntry = false
        }
        else {
            passwordTextField.isSecureTextEntry = true
        }
    }
    
}
