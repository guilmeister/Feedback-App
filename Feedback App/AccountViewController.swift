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
    @IBOutlet weak var menuLabelBackgroundImageView: UIImageView!
    @IBOutlet weak var couponLabelBackgroundImageView: UIImageView!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var couponButton: UIButton!
    let customer = DatabaseHelper.inst.fetchUsernameSpecifiedData(username: SignInViewController.userIdentifier!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabelBorders()
        setupButtonBorders()
        setLabelData()
    }
    
    func setupButtonBorders() {
        //Setup for Update Button
        updateButton.layer.cornerRadius = 10.0
        updateButton.layer.masksToBounds = true
        updateButton.layer.borderColor = UIColor.black.cgColor
        updateButton.layer.borderWidth = 1.0
        //Setup for Coupon Button
        couponButton.layer.cornerRadius = 10.0
        couponButton.layer.masksToBounds = true
        couponButton.layer.borderColor = UIColor.black.cgColor
        couponButton.layer.borderWidth = 1.0
    }
    
    func setupLabelBorders() {
        //Setup for Menu Background
        menuLabelBackgroundImageView.layer.cornerRadius = 10.0
        menuLabelBackgroundImageView.clipsToBounds = true
        menuLabelBackgroundImageView.layer.borderColor = UIColor.black.cgColor
        menuLabelBackgroundImageView.layer.borderWidth = 1.0
        //Setup for Coupon Background
        couponLabelBackgroundImageView.layer.cornerRadius = 10.0
        couponLabelBackgroundImageView.clipsToBounds = true
        couponLabelBackgroundImageView.layer.borderColor = UIColor.black.cgColor
        couponLabelBackgroundImageView.layer.borderWidth = 1.0
    }
    
    func setLabelData() {
        if (customer.roomScore == 0.0) {
            roomCode.text = "N/A"
        }
        else {
            roomCode.text = "OFF30ROOMRESORT"
        }
        if (customer.gymScore == 0.0) {
            gymCode.text = "N/A"
        }
        else {
            gymCode.text = "OFF30GYMRESORT"
        }
        if (customer.foodScore == 0.0) {
            foodCode.text = "N/A"
        }
        else {
            foodCode.text = "OFF30FOODRESORT"
        }
        if (customer.spaScore == 0.0) {
            spaCode.text = "N/A"
        }
        else {
            spaCode.text = "OFF30SPARESORT"
        }
    }
}
