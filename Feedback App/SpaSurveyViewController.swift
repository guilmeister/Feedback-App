//
//  SpaSurveyViewController.swift
//  Feedback App
//
//  Created by Edward Guilllermo on 4/28/21.
//

import UIKit

class SpaSurveyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerTableView: UITableView!
    var surveyQuestions = [Question]()
    var currentQuestion : Question?
    var surveyTotalPoints : Float = 0.0
    var currentPoints : Float = 0.0
    static var spaSurveyScore : Float?
    
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Spa", for: indexPath)
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
                let spaScoreAverage = currentPoints / 5
                let userIdentifier = SignInViewController.userIdentifier!
                SpaSurveyViewController.spaSurveyScore = spaScoreAverage
                DatabaseHelper.inst.endSpaSurvey(username: userIdentifier, spaScore: spaScoreAverage)
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
        
        surveyQuestions.append(Question(text: "How was the Spa upon arrival?", choice: [
            Choice(text: "Extremely Clean"),
            Choice(text: "Quite Clean"),
            Choice(text: "Moderately Clean"),
            Choice(text: "Slightly Clean"),
            Choice(text: "Not Clean")
        ]))
        
        surveyQuestions.append(Question(text: "How well did the staff clean the Spa?", choice: [
            Choice(text: "Extremely Well"),
            Choice(text: "Quite Well"),
            Choice(text: "Moderately Well"),
            Choice(text: "Slightly Well"),
            Choice(text: "Not Well")
        ]))
        
        surveyQuestions.append(Question(text: "How relaxing was the Spa?", choice: [
            Choice(text: "Extremely Relaxing"),
            Choice(text: "Quite Relaxing"),
            Choice(text: "Moderately Relaxing"),
            Choice(text: "Slightly Relaxing"),
            Choice(text: "Not Relaxing")
        ]))
        
        surveyQuestions.append(Question(text: "How clear were the instructions on how to use Spa?", choice: [
            Choice(text: "Extremely Clear"),
            Choice(text: "Quite Clear"),
            Choice(text: "Moderately Clear"),
            Choice(text: "Slightly Clear"),
            Choice(text: "Not Clear")
        ]))
        
        surveyQuestions.append(Question(text: "How helpful were the staff in the Spa?", choice: [
            Choice(text: "Extremely Helpful"),
            Choice(text: "Quite Helpful"),
            Choice(text: "Moderately Helpful"),
            Choice(text: "Slightly Helpful"),
            Choice(text: "Not Helpful")
        ]))
        
    }
    
}
