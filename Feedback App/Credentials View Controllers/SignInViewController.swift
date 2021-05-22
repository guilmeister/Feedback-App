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
    @IBOutlet weak var signInLogo: UIImageView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var forgotPassButton: UIButton!
    @IBOutlet weak var infoView: UIView!
    let uDefault = UserDefaults.standard
    var signInSuccess : Bool = false
    static var userIdentifier : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserDefaults()
        setupLogoBorder()
        setupViewBorder()
        setupButtonBorders()
    }
    
    func setupUserDefaults() {
        //Function that sets up the User Default's state and saved values
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
    
    func setupLogoBorder() {
        //Function that sets up the properties for UIImageView Objects
        signInLogo.layer.masksToBounds = true
        signInLogo.layer.cornerRadius = signInLogo.bounds.width / 2
    }
    
    func setupViewBorder() {
        //Function that sets up the properties for UIView Objects
        infoView.layer.cornerRadius = 10.0
        infoView.layer.masksToBounds = true
        infoView.layer.borderWidth = 1.0
        infoView.layer.borderColor = UIColor.black.cgColor
    }

    func setupButtonBorders() {
        //Function that sets up the properties for UIButton Objects
        
        //Setup for Sign In Button
        signInButton.layer.cornerRadius = 10.0
        signInButton.layer.masksToBounds = true
        signInButton.layer.borderColor = UIColor.black.cgColor
        signInButton.layer.borderWidth = 1.0
        //Setup for Forgot Pass Button
        forgotPassButton.layer.cornerRadius = 10.0
        forgotPassButton.layer.masksToBounds = true
        forgotPassButton.layer.borderColor = UIColor.black.cgColor
        forgotPassButton.layer.borderWidth = 1.0
    }
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        //Function that checks if values in text fields for username and password match the values saved inside Core Data. It will instantiate to the HomeViewController if verified
        let customerData = DatabaseHelper.inst.fetchData()
        
        for c in customerData {
            if (usernameTextField.text == "" || passwordTextField.text == "") {
                let alert = UIAlertController(title: "Error", message: "Text field for Username and Password must not be blank!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                usernameTextField.text = ""
                passwordTextField.text = ""
            }
            if (c.username == usernameTextField.text && c.password == passwordTextField.text) {
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
        //Function that sets the UserDefaults to remember last value of usernameTextField and passwordTextField
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
