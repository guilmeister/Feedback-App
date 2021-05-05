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
    let customer = DatabaseHelper.inst.fetchUsernameSpecifiedData(username: SignInViewController.userIdentifier!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
