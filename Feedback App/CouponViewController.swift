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
    let customer = DatabaseHelper.inst.fetchUsernameSpecifiedData(username: SignInViewController.userIdentifier!)
    let missingRoomSurveyText = "Please complete Room Survey to avail for this coupon on your account"
    let missingGymSurveyText = "Please complete Gym Survey to avail for this coupon on your account"
    let missingFoodSurveyText = "Please complete Food Survey to avail for this coupon on your account"
    let missingSpaSurveyText = "Please complete Spa Survey to avail for this coupon on your account"
    let surveyCompleteText = "Survey Completed, thank you. The coupon code is now available on your account page, show it to the front desk on your next visit"
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
