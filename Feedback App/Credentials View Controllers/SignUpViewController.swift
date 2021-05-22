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
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signUpIcon: UIImageView!
    @IBOutlet weak var signUpView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonBorders()
        setupLogoBorders()
        setupViewBorder()
    }
    
    func setupButtonBorders() {
        //Function that sets up the properties for UIButton Objects
        signUpButton.layer.cornerRadius = 10.0
        signUpButton.layer.masksToBounds = true
        signUpButton.layer.borderColor = UIColor.black.cgColor
        signUpButton.layer.borderWidth = 1.0
    }
    
    func setupLogoBorders() {
        //Function that sets up the properties for UIImageView Objects
        signUpIcon.layer.masksToBounds = true
        signUpIcon.layer.cornerRadius = signUpIcon.bounds.width / 2
    }
    
    func setupViewBorder() {
        //Function that sets up the properties for UIView Objects
        signUpView.layer.cornerRadius = 10.0
        signUpView.layer.masksToBounds = true
        signUpView.layer.borderColor = UIColor.black.cgColor
        signUpView.layer.borderWidth = 1.0
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
         //Function that takes in Username and Password from respective text fields and stores it inside Core Data Store after validation
        let customerData = DatabaseHelper.inst.fetchData()
        var isUnique : Bool
        var signUpSuccess : Bool = false
        var index = 0
        
        if (customerData.isEmpty) {
            isUnique = validateInputs(customerData: customerData)
            if (isUnique) {
                let dict = ["username" : userTextField.text, "password" : passwordTextField.text]
                DatabaseHelper.inst.signUpButtonClicked(object: dict as! [String : String])
                userTextField.text = ""
                passwordTextField.text = ""
                signUpSuccess = true
            }
            if (signUpSuccess) {
                let sBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let signInPage = sBoard.instantiateViewController(identifier: "SignIn") as! SignInViewController
                present(signInPage, animated: true, completion: nil)
            }
        }
        
        for c in customerData {
            isUnique = validateInputs(customerData: customerData)
            if (index == customerData.count - 1 && isUnique) {
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
         //Function that checks if a user input in the userTextField or passwordTextField is acceptable and returns true by default if any of the conditions are not met
        for c in customerData {
            if (userTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty || passwordTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty) {
                let alert = UIAlertController(title: "Error", message: "Text field for Username and Password must not be blank!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                userTextField.text = ""
                passwordTextField.text = ""
                return false
            }
            if (c.username == userTextField.text) {
                let alert = UIAlertController(title: "Error", message: "Username taken, please input another username!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                userTextField.text = ""
                passwordTextField.text = ""
                return false
            }
            if (userTextField.text!.count < 4) {
                let alert = UIAlertController(title: "Error", message: "Less than 4 characters, minimum of 4 and maximum of 12 characters allowed in a username!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                userTextField.text = ""
                passwordTextField.text = ""
                return false
            }
            if (userTextField.text!.count > 12) {
                let alert = UIAlertController(title: "Error", message: "Too many characters, only 12 characters allowed in a username!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                userTextField.text = ""
                passwordTextField.text = ""
                return false
            }
            if (passwordTextField.text!.count < 4) {
                let alert = UIAlertController(title: "Error", message: "Less than 4 characters, minimum of 4 and maximum of 12 characters allowed in a password!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                userTextField.text = ""
                passwordTextField.text = ""
                return false
            }
            if (passwordTextField.text!.count > 12) {
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
        //Function that toggles the Secure Text Entry property of the passwordTextField
        let passwordSecureState = passwordTextField.isSecureTextEntry
        if (passwordSecureState) {
            passwordTextField.isSecureTextEntry = false
        }
        else {
            passwordTextField.isSecureTextEntry = true
        }
    }
}
