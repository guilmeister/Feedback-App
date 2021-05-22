//
//  OverallSurveyViewController.swift
//  Feedback App
//
//  Created by Edward Guilllermo on 4/28/21.
//

import UIKit

class OverallSurveyViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerTableView: UITableView!
    @IBOutlet weak var overallIcon: UIImageView!
    var surveyQuestions = [Question]()
    var currentQuestion : Question?
    var surveyTotalPoints : Float = 0.0
    var currentPoints : Float = 0.0
    static var overallSurveyScore : Float?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerTableView.delegate = self
        answerTableView.dataSource = self
        setupLabelBorders()
        setupLogoBorders()
        setupTableViewBorder()
        setUpQuestions()
        configureUI(question: surveyQuestions.first!)
    }
    
    func setupLabelBorders() {
        //Function that sets up the properties for UILabel Objects
        questionLabel.layer.cornerRadius = 10.0
        questionLabel.layer.masksToBounds = true
        questionLabel.layer.borderColor = UIColor.black.cgColor
        questionLabel.layer.borderWidth = 1.0
    }
    
    func setupLogoBorders() {
        //Function that sets up the properties for UIImageView Objects
        overallIcon.layer.masksToBounds = true
        overallIcon.layer.cornerRadius = overallIcon.bounds.width / 2
    }
    
    func setupTableViewBorder() {
        //Function that sets up the properties for UITableView Objects
        answerTableView.layer.cornerRadius = 10.0
        answerTableView.layer.masksToBounds = true
        answerTableView.layer.borderColor = UIColor.black.cgColor
        answerTableView.layer.borderWidth = 1.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Function that tells the data source to return the number of rows in a given section
        return currentQuestion?.choice.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Function that asks the data source for a cell to insert in a particular location of the table view
        let cell = tableView.dequeueReusableCell(withIdentifier: "Overall", for: indexPath)
        cell.textLabel?.text = currentQuestion?.choice[indexPath.row].text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Function that tells the delegate which row is selected
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
                let overallScoreAverage = currentPoints / 5
                let userIdentifier = SignInViewController.userIdentifier!
                OverallSurveyViewController.overallSurveyScore = overallScoreAverage
                DatabaseHelper.inst.endOverallSurvey(username: userIdentifier, overallScore: overallScoreAverage)
                let sBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let homePage = sBoard.instantiateViewController(identifier: "Home") as! HomeViewController
                present(homePage, animated: true, completion: nil)
                print("Survey Successful, Back to Home Page")
            }
        }
    }
    
    func getTotal(value : Int) -> Float {
        //Function that returns a set value depending on the row selected in the survey
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
        //Function that sets the question stored in the array
        questionLabel.text = question.text
        currentQuestion = question
        answerTableView.reloadData()
    }
    
    private func setUpQuestions() {
        //Function that appends static questions and answers to the surveyQuestions array. The structure for Question and Choice is found on DatabaseHelper.swift file
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
