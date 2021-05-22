//
//  AccountViewController.swift
//  Feedback App
//
//  Created by Edward Guilllermo on 5/3/21.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var roomCode: UILabel!
    @IBOutlet weak var gymCode: UILabel!
    @IBOutlet weak var foodCode: UILabel!
    @IBOutlet weak var spaCode: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var accountIcon: UIImageView!
    @IBOutlet weak var accountView: UIView!
    let customer = DatabaseHelper.inst.fetchUsernameSpecifiedData(username: SignInViewController.userIdentifier!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonBorders()
        setupLabelData()
        setupLogoBorders()
        setupViewBorder()
    }
    
    func setupButtonBorders() {
        //Function that sets up the properties for UIButton Objects

        //Setup for Update Button
        updateButton.layer.cornerRadius = 10.0
        updateButton.layer.masksToBounds = true
        updateButton.layer.borderColor = UIColor.black.cgColor
        updateButton.layer.borderWidth = 1.0
        //Setup for Coupon Button
        deleteButton.layer.cornerRadius = 10.0
        deleteButton.layer.masksToBounds = true
        deleteButton.layer.borderColor = UIColor.black.cgColor
        deleteButton.layer.borderWidth = 1.0
    }
    
    func setupLabelData() {
        //Function that sets up label values for UILabel Objects
        if (customer.roomScore == 0.0) {
            roomCode.isHidden = true
        }
        else {
            roomCode.isHidden = false
            roomCode.text = "Room Code: OFF30ROOM"
        }
        if (customer.gymScore == 0.0) {
            gymCode.isHidden = true
        }
        else {
            gymCode.isHidden = false
            gymCode.text = "Gym Code: OFF30GYM"
        }
        if (customer.foodScore == 0.0) {
            foodCode.isHidden = true
        }
        else {
            foodCode.isHidden = false
            foodCode.text = "Food Code: OFF30FOOD"
        }
        if (customer.spaScore == 0.0) {
            spaCode.isHidden = true
        }
        else {
            spaCode.isHidden = false
            spaCode.text = "Spa Code: OFF30SPA"
        }
    }
    
    func setupLogoBorders() {
        //Function that sets up the properties for UIImageView Objects
        accountIcon.layer.masksToBounds = true
        accountIcon.layer.cornerRadius = accountIcon.bounds.width / 2
    }
    
    func setupViewBorder() {
        //Function that sets up the properties for UIView Objects
        accountView.layer.cornerRadius = 10.0
        accountView.layer.masksToBounds = true
        accountView.layer.borderColor = UIColor.black.cgColor
        accountView.layer.borderWidth = 1.0
    }
    
    @IBAction func deleteAccount(_ sender: Any) {
        //Function that deletes the User's account that is currently logged on
        let alert = UIAlertController(title: "Deleting Account", message: "Are you sure you want to delete this account? Action is irreversible!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { (action: UIAlertAction!) in
            DatabaseHelper.inst.deleteData(username: SignInViewController.userIdentifier!)
            let sBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let signInPage = sBoard.instantiateViewController(identifier: "SignIn") as! SignInViewController
            self.present(signInPage, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
