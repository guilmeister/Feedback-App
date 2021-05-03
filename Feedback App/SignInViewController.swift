//
//  SignInViewController.swift
//  Feedback App
//
//  Created by Edward Guilllermo on 4/25/21.
//

import UIKit
import SafariServices

class SignInViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberSwitch: UISwitch!
    let uDefault = UserDefaults.standard
    static var userIdentifier : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                let sBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let homePage = sBoard.instantiateViewController(identifier: "Home") as! HomeViewController
                present(homePage, animated: true, completion: nil)
                print("Sign In Successful")
            }
            else {
                print("Sign In Unsuccessful")
            }
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
    
    @IBAction func facebookSignIn(_ sender: Any) {
        let facebookLink = SFSafariViewController(url: URL(string: "https://www.facebook.com")!)
        present(facebookLink, animated: true)
    }
    
    @IBAction func twitterSignIn(_ sender: Any) {
        let twitterLink = SFSafariViewController(url: URL(string: "https://www.twitter.com")!)
        present(twitterLink, animated: true)
    }
    
}
