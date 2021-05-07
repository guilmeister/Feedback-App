//
//  CouponViewController.swift
//  Feedback App
//
//  Created by Edward Guilllermo on 5/3/21.
//

import UIKit

class CouponViewController: UIViewController {

    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var gymLabel: UILabel!
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var spaLabel: UILabel!
    @IBOutlet weak var roomBackgroundImageView: UIImageView!
    @IBOutlet weak var gymBackgroundImageView: UIImageView!
    @IBOutlet weak var foodBackgroundImageView: UIImageView!
    @IBOutlet weak var spaBackgroundImageView: UIImageView!
    let customer = DatabaseHelper.inst.fetchUsernameSpecifiedData(username: SignInViewController.userIdentifier!)
    let missingRoomSurveyText = "Please complete Room Survey to avail for this coupon on your account"
    let missingGymSurveyText = "Please complete Gym Survey to avail for this coupon on your account"
    let missingFoodSurveyText = "Please complete Food Survey to avail for this coupon on your account"
    let missingSpaSurveyText = "Please complete Spa Survey to avail for this coupon on your account"
    let surveyCompleteText = "Survey Completed, thank you. The coupon code is now available on your account page, show it to the front desk on your next visit"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabelBorders()
        setLabelData()
    }
    
    func setupLabelBorders() {
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
    }
    
    func setLabelData() {
        if (customer.roomScore == 0) {
            roomLabel.text = missingRoomSurveyText
        }
        else {
            roomLabel.text = surveyCompleteText
        }
        if (customer.gymScore == 0) {
            gymLabel.text = missingGymSurveyText
        }
        else {
            gymLabel.text = surveyCompleteText
        }
        if (customer.foodScore == 0) {
            foodLabel.text = missingFoodSurveyText
        }
        else {
            foodLabel.text = surveyCompleteText
        }
        if (customer.spaScore == 0) {
            spaLabel.text = missingSpaSurveyText
        }
        else {
            spaLabel.text = surveyCompleteText
        }
    }
    
}
