//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    var questionNumber: Int = 0

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreTotalLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreTotalLabel.text = "0"
        progressLabel.text = "0"

        nextQuestion()
    }

    @IBAction func answerPressed(_ sender: AnyObject) {
        let currentQuestion = allQuestions.list[questionNumber]
        let givenAnswer: Bool = sender.tag == 1 ? true : false

        checkAnswer(question: currentQuestion, givenAnswer: givenAnswer)
    }

    func updateUI(correctAnswer: Bool) {
        var score = Int(scoreTotalLabel.text!)
        var progress = Int(progressLabel.text!)

        if correctAnswer {
            score = score! + 1
            scoreTotalLabel.text = String(score!)
            ProgressHUD.showSuccess("Correct")
        } else {
            ProgressHUD.showError("Wrong")
        }


        progress = progress! + 1
        progressLabel.text = String(progress!)

        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(progress!)

        if progress! <= 12 {
            nextQuestion()
        } else {
            // UIAlert Controller is a popup
            // Instead of modal can have sheet from bottom with: preferredStyle: .actionSheet
            let alert  = UIAlertController(title: "End of Quiz", message: "Start Over?", preferredStyle: .alert)

            // UIAlertAction adds buttons
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver()
            }

            // Need to add UIAlertAction to UIAlert for buttons to show on popup
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
    }

    func nextQuestion() {
        questionNumber = Int(arc4random_uniform(10))
        questionLabel.text = allQuestions.list[questionNumber].questionText
    }
    
    
    func checkAnswer(question: Question, givenAnswer: Bool) {
        print("\n--------------------------")
        print("Question: \(question.questionText)")
        print("Correct Answer: \(question.answer)")
        print("Given answer:   \(givenAnswer)")

        let correctAnswer: Bool = question.answer == givenAnswer
        updateUI(correctAnswer: correctAnswer)
    }
    
    
    func startOver() {
        scoreTotalLabel.text = "0"
        progressLabel.text = "0"
        nextQuestion()
    }

}
