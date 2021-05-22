//
//  HomeViewController.swift
//  Feedback App
//
//  Created by Edward Guilllermo on 4/25/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var roomScore: UILabel!
    @IBOutlet weak var gymScore: UILabel!
    @IBOutlet weak var foodScore: UILabel!
    @IBOutlet weak var spaScore: UILabel!
    @IBOutlet weak var overallScore: UILabel!
    @IBOutlet weak var roomButton: UIButton!
    @IBOutlet weak var gymButton: UIButton!
    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var spaButton: UIButton!
    @IBOutlet weak var overallButton: UIButton!
    @IBOutlet weak var manageAccountButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var homeLogo: UIImageView!
    @IBOutlet weak var homeView: UIView!
    let customer = DatabaseHelper.inst.fetchUsernameSpecifiedData(username: SignInViewController.userIdentifier!)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonBorders()
        setupLabelData()
        setupLogoBorders()
        setupViewBorder()
        setupButtonStatus()
    }
    
    func setupButtonBorders() {
        //Function that sets up the properties for UIButton Objects
        
        //Setup for Manage Account Button
        manageAccountButton.layer.cornerRadius = 10.0
        manageAccountButton.layer.masksToBounds = true
        manageAccountButton.layer.borderColor = UIColor.black.cgColor
        manageAccountButton.layer.borderWidth = 1.0
        //Setup for Log Out Button
        logOutButton.layer.cornerRadius = 10.0
        logOutButton.layer.masksToBounds = true
        logOutButton.layer.borderColor = UIColor.black.cgColor
        logOutButton.layer.borderWidth = 1.0
        //Setup for Room Button
        roomButton.layer.cornerRadius = 10.0
        roomButton.layer.masksToBounds = true
        roomButton.layer.borderColor = UIColor.black.cgColor
        roomButton.layer.borderWidth = 1.0
        //Setup for Gym Button
        gymButton.layer.cornerRadius = 10.0
        gymButton.layer.masksToBounds = true
        gymButton.layer.borderColor = UIColor.black.cgColor
        gymButton.layer.borderWidth = 1.0
        //Setup for Food Button
        foodButton.layer.cornerRadius = 10.0
        foodButton.layer.masksToBounds = true
        foodButton.layer.borderColor = UIColor.black.cgColor
        foodButton.layer.borderWidth = 1.0
        //Setup for Spa Button
        spaButton.layer.cornerRadius = 10.0
        spaButton.layer.masksToBounds = true
        spaButton.layer.borderColor = UIColor.black.cgColor
        spaButton.layer.borderWidth = 1.0
        //Setup for Overall Button
        overallButton.layer.cornerRadius = 10.0
        overallButton.layer.masksToBounds = true
        overallButton.layer.borderColor = UIColor.black.cgColor
        overallButton.layer.borderWidth = 1.0
    }
    
    func setupLabelData() {
        //Function that sets up label values for UILabel Objects
        usernameLabel.text = "Welcome \(customer.username!)!"
        roomScore.text = "Room Rating: \(customer.roomScore)"
        gymScore.text = "Gym Rating: \(customer.gymScore)"
        foodScore.text = "Food Rating: \(customer.foodScore)"
        spaScore.text = "Spa Rating: \(customer.spaScore)"
        overallScore.text = "Overall Rating: \(customer.overallScore)"
    }
    
    func setupLogoBorders() {
        //Function that sets up the properties for UIImageView Objects
        homeLogo.layer.masksToBounds = true
        homeLogo.layer.cornerRadius = homeLogo.bounds.width / 2
    }
    
    func setupViewBorder() {
        //Function that sets up the properties for UIView Objects
        homeView.layer.cornerRadius = 10.0
        homeView.layer.masksToBounds = true
        homeView.layer.borderColor = UIColor.black.cgColor
        homeView.layer.borderWidth = 1.0
    }
    
    func setupButtonStatus() {
        //Function that disables Feedback Button Objects if a User has finished answering a Feedback
        if (customer.roomScore != 0.0) {
            roomButton.isEnabled = false
            roomButton.backgroundColor = .systemGray
        }
        if (customer.gymScore != 0.0) {
            gymButton.isEnabled = false
            gymButton.backgroundColor = .systemGray
        }
        if (customer.foodScore != 0.0) {
            foodButton.isEnabled = false
            foodButton.backgroundColor = .systemGray
        }
        if (customer.spaScore != 0.0) {
            spaButton.isEnabled = false
            spaButton.backgroundColor = .systemGray
        }
        if (customer.overallScore != 0.0) {
            overallButton.isEnabled = false
            overallButton.backgroundColor = .systemGray
        }
    }

    @IBAction func logoutButtonClicked(_ sender: Any) {
        //Function that logs the current User out and instantiates to SignInViewController
        let sBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signInPage = sBoard.instantiateViewController(identifier: "SignIn") as! SignInViewController
        present(signInPage, animated: true, completion: nil)
    }
}
