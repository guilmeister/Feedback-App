//
//  AdminViewController.swift
//  Feedback App
//
//  Created by Edward Guilllermo on 4/28/21.
//

import UIKit

class AdminViewController: UIViewController {
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

    }
    
    @IBAction func viewAll(_ sender: Any) {
        let data = DatabaseHelper.inst.fetchData()
        for c in data {
            print("Username is \(c.username) with password \(c.password) with roomScore \(c.roomScore) with gymScore \(c.gymScore) with foodScore \(c.foodScore) with spaScore \(c.spaScore) with overallScore \(c.overallScore)")
        }
    }
    
    @IBAction func viewOne(_ sender: Any) {
        let data = DatabaseHelper.inst.fetchUsernameSpecifiedData(username: userTextField.text!)
        print("Username is \(data.username) with password \(data.password)")
    }
    
    @IBAction func deleteOne(_ sender: Any) {
        DatabaseHelper.inst.deleteData(username: userTextField.text!)
    }
    
    @IBAction func updateOne(_ sender: Any) {
    }
    

}
