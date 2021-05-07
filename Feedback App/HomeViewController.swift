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
    @IBOutlet weak var labelBackgroundImageView: UIImageView!
    @IBOutlet weak var roomBackgroundImageView: UIImageView!
    @IBOutlet weak var gymBackgroundImageView: UIImageView!
    @IBOutlet weak var foodBackgroundImageView: UIImageView!
    @IBOutlet weak var spaBackgroundImageView: UIImageView!
    @IBOutlet weak var overallBackgroundImageView: UIImageView!
    @IBOutlet weak var userBackgroundImageView: UIImageView!
    @IBOutlet weak var roomButton: UIButton!
    @IBOutlet weak var gymButton: UIButton!
    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var spaButton: UIButton!
    @IBOutlet weak var overallButton: UIButton!
    @IBOutlet weak var manageAccountButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    let customer = DatabaseHelper.inst.fetchUsernameSpecifiedData(username: SignInViewController.userIdentifier!)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabelBorders()
        setupButtonBorders()
        setLabelData()
    }
    
    func setupButtonBorders() {
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
    
    func setupLabelBorders() {
        //Setup Main Background
        labelBackgroundImageView.layer.cornerRadius = 10.0
        labelBackgroundImageView.clipsToBounds = true
        labelBackgroundImageView.layer.borderColor = UIColor.black.cgColor
        labelBackgroundImageView.layer.borderWidth = 1.0
        //Setup Room Background
        roomBackgroundImageView.layer.cornerRadius = 10.0
        roomBackgroundImageView.clipsToBounds = true
        roomBackgroundImageView.layer.borderColor = UIColor.black.cgColor
        roomBackgroundImageView.layer.borderWidth = 1.0
        //Setup Gym Background
        gymBackgroundImageView.layer.cornerRadius = 10.0
        gymBackgroundImageView.clipsToBounds = true
        gymBackgroundImageView.layer.borderColor = UIColor.black.cgColor
        gymBackgroundImageView.layer.borderWidth = 1.0
        //Setup Food Background
        foodBackgroundImageView.layer.cornerRadius = 10.0
        foodBackgroundImageView.clipsToBounds = true
        foodBackgroundImageView.layer.borderColor = UIColor.black.cgColor
        foodBackgroundImageView.layer.borderWidth = 1.0
        //Setup Spa Background
        spaBackgroundImageView.layer.cornerRadius = 10.0
        spaBackgroundImageView.clipsToBounds = true
        spaBackgroundImageView.layer.borderColor = UIColor.black.cgColor
        spaBackgroundImageView.layer.borderWidth = 1.0
        //Setup Overall Background
        overallBackgroundImageView.layer.cornerRadius = 10.0
        overallBackgroundImageView.clipsToBounds = true
        overallBackgroundImageView.layer.borderColor = UIColor.black.cgColor
        overallBackgroundImageView.layer.borderWidth = 1.0
        //Setup User Background
        userBackgroundImageView.layer.cornerRadius = userBackgroundImageView.frame.size.width / 2
        userBackgroundImageView.clipsToBounds = true
        userBackgroundImageView.layer.borderColor = UIColor.black.cgColor
        userBackgroundImageView.layer.borderWidth = 1.0
    }
    
    func setLabelData() {
        usernameLabel.text = customer.username
        roomScore.text = String(customer.roomScore)
        gymScore.text = String(customer.gymScore)
        foodScore.text = String(customer.foodScore)
        spaScore.text = String(customer.spaScore)
        overallScore.text = String(customer.overallScore)
    }

    @IBAction func logoutButtonClicked(_ sender: Any) {
        
        if (customer.overallScore < 3.0) {
            let sBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let sadPage = sBoard.instantiateViewController(identifier: "Sad") as! SadExitViewController
            present(sadPage, animated: true, completion: nil)
            print("Welcome Admin")
        }
        else if (customer.overallScore > 3.0 && (customer.roomScore < 3.0 || customer.gymScore < 3.0 || customer.foodScore < 3.0 || customer.spaScore < 3.0)) {
            let sBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let neutralPage = sBoard.instantiateViewController(identifier: "Neutral") as! NeutralExitViewController
            present(neutralPage, animated: true, completion: nil)
        }
        else {
            let sBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let happyPage = sBoard.instantiateViewController(identifier: "Happy") as! HappyExitViewController
            present(happyPage, animated: true, completion: nil)
        }
    }
    
}
