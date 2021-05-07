//
//  SignInViewController.swift
//  Feedback App
//
//  Created by Edward Guilllermo on 4/25/21.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberLabel: UILabel!
    @IBOutlet weak var rememberSwitch: UISwitch!
    @IBOutlet weak var labelBackgroundImageView: UIImageView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var forgotPassButton: UIButton!
    let uDefault = UserDefaults.standard
    var signInSuccess : Bool = false
    static var userIdentifier : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabelBorders()
        setupButtonBorders()
        if (uDefault.object(forKey: "switchState") != nil) {
            rememberSwitch.isOn = uDefault.bool(forKey: "switchState")
        }
        if let userValue = uDefault.value(forKey: "username") as? String {
            usernameTextField.text = userValue
        }
        if let passValue = uDefault.value(forKey: "password") as? String {
            passwordTextField.text = passValue
        }
    }

    func setupButtonBorders() {
        //Setup for Sign In Button
        signInButton.layer.cornerRadius = 10.0
        signInButton.layer.masksToBounds = true
        signInButton.layer.borderColor = UIColor.black.cgColor
        signInButton.layer.borderWidth = 1.0
        //Setup for Sign Up Button
        signUpButton.layer.cornerRadius = 10.0
        signUpButton.layer.masksToBounds = true
        signUpButton.layer.borderColor = UIColor.black.cgColor
        signUpButton.layer.borderWidth = 1.0
        //Setup for Forgot Pass Button
        forgotPassButton.layer.cornerRadius = 10.0
        forgotPassButton.layer.masksToBounds = true
        forgotPassButton.layer.borderColor = UIColor.black.cgColor
        forgotPassButton.layer.borderWidth = 1.0
    }
    
    func setupLabelBorders() {
        labelBackgroundImageView.layer.cornerRadius = 10.0
        labelBackgroundImageView.clipsToBounds = true
        labelBackgroundImageView.layer.borderColor = UIColor.black.cgColor
        labelBackgroundImageView.layer.borderWidth = 1.0
    }
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        let customerData = DatabaseHelper.inst.fetchData()
        
        if (usernameTextField.text == "admin" && passwordTextField.text == "admin") {
            //Checks for admin credentials, for debugging purposes
            let sBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let adminPage = sBoard.instantiateViewController(identifier: "Admin") as! AdminViewController
            present(adminPage, animated: true, completion: nil)
            print("Welcome Admin")
        }
        for c in customerData {
            if (usernameTextField.text == "" || passwordTextField.text == "") {
                //Checks if either text fields are left blank by user
                print("Text field for Username and Password must not be blank")
                usernameTextField.text = ""
                passwordTextField.text = ""
            }
            if (c.username == usernameTextField.text && c.password == passwordTextField.text) {
                //Checks if username and password text fields match the values saved in Core Data
                SignInViewController.userIdentifier = c.username
                usernameTextField.text = ""
                passwordTextField.text = ""
                signInSuccess = true
                print("Sign In Successful")
                break
            }
            else {
                print("Sign In Unsuccessful")
            }
        }
        if (signInSuccess) {
            let sBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homePage = sBoard.instantiateViewController(identifier: "Home") as! HomeViewController
            present(homePage, animated: true, completion: nil)
        }
    }
    
    @IBAction func rememberSwitchSwiped(_ sender: Any) {
        print("Switch Swiped")
        if (rememberSwitch.isOn) {
            uDefault.setValue(usernameTextField.text, forKey: "username")
            uDefault.setValue(passwordTextField.text, forKey: "password")
            uDefault.setValue(true, forKey: "switchState")
        }
        else {
            uDefault.removeObject(forKey: "username")
            uDefault.removeObject(forKey: "password")
            uDefault.setValue(false, forKey: "switchState")
        }
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
