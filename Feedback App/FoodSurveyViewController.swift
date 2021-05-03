//
//  FoodSurveyViewController.swift
//  Feedback App
//
//  Created by Edward Guilllermo on 4/28/21.
//

import UIKit

class FoodSurveyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerTableView: UITableView!
    var surveyQuestions = [Question]()
    var currentQuestion : Question?
    var surveyTotalPoints : Float = 0.0
    var currentPoints : Float = 0.0
    static var foodSurveyScore : Float?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        answerTableView.delegate = self
        answerTableView.dataSource = self
        setUpQuestions()
        configureUI(question: surveyQuestions.first!)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return currentQuestion?.choice.count ?? 0 // If value is nil, return 0

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Food", for: indexPath)
        cell.textLabel?.text = currentQuestion?.choice[indexPath.row].text
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        guard let question = currentQuestion else {
            return
        }
        if let index = surveyQuestions.firstIndex(where: { $0.text == question.text }) {
            if index < (surveyQuestions.count - 1) {
                let selectedItem = indexPath.row
                currentPoints = getTotal(value: selectedItem)
                let nextQuestion = surveyQuestions[index + 1]
                configureUI(question: nextQuestion)
                answerTableView.reloadData()
            }
            else {
                let selectedItem = indexPath.row
                currentPoints = getTotal(value: selectedItem)
                let foodScoreAverage = currentPoints / 5
                let userIdentifier = SignInViewController.userIdentifier!
                FoodSurveyViewController.foodSurveyScore = foodScoreAverage
                DatabaseHelper.inst.endFoodSurvey(username: userIdentifier, foodScore: foodScoreAverage)
                let sBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let homePage = sBoard.instantiateViewController(identifier: "Home") as! HomeViewController
                present(homePage, animated: true, completion: nil)
                print("Survey Successful, Back to Home Page")
            }
        }
    }
    
    func getTotal(value : Int) -> Float {
        
        switch value {
        
        case 0:
            surveyTotalPoints += 5.0
        case 1:
            surveyTotalPoints += 4.0
        case 2:
            surveyTotalPoints += 3.0
        case 3:
            surveyTotalPoints += 2.0
        case 4:
            surveyTotalPoints += 1.0
        default:
            print("")
            
        }
        return surveyTotalPoints
    }
    
    private func configureUI(question : Question) {
        
        questionLabel.text = question.text
        currentQuestion = question
        answerTableView.reloadData()
        
    }
    
    private func setUpQuestions() {
        
        surveyQuestions.append(Question(text: "How was the Hotel upon arrival?", choice: [
            Choice(text: "Extremely Clean"),
            Choice(text: "Quite Clean"),
            Choice(text: "Moderately Clean"),
            Choice(text: "Slightly Clean"),
            Choice(text: "Not Clean")
        ]))
        
        surveyQuestions.append(Question(text: "How well did the staff accomodate to your needs?", choice: [
            Choice(text: "Extremely Well"),
            Choice(text: "Quite Well"),
            Choice(text: "Moderately Well"),
            Choice(text: "Slightly Well"),
            Choice(text: "Not Well")
        ]))
        
        surveyQuestions.append(Question(text: "How was your overall experience with us?", choice: [
            Choice(text: "Extremely Good"),
            Choice(text: "Quite Good"),
            Choice(text: "Moderately Good"),
            Choice(text: "Slightly Good"),
            Choice(text: "Not Good")
        ]))
        
        surveyQuestions.append(Question(text: "Will you visit us again?", choice: [
            Choice(text: "Extremely Likely"),
            Choice(text: "Quite Likely"),
            Choice(text: "Moderately Likely"),
            Choice(text: "Slightly Likely"),
            Choice(text: "Not Likely")
        ]))
        
        surveyQuestions.append(Question(text: "Will you recommend us to your friends and family for their accomodations?", choice: [
            Choice(text: "Extremely Likely"),
            Choice(text: "Quite Likely"),
            Choice(text: "Moderately Likely"),
            Choice(text: "Slightly Likely"),
            Choice(text: "Not Likely")
        ]))
        
    }

}
