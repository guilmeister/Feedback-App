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
    let customer = DatabaseHelper.inst.fetchUsernameSpecifiedData(username: SignInViewController.userIdentifier!)

    override func viewDidLoad() {
        super.viewDidLoad()
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
