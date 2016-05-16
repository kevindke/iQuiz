//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Kevin Ke on 5/12/16.
//  Copyright © 2016 Kevin Ke. All rights reserved.
//

import UIKit
import Foundation

class AnswerViewController: UIViewController{
    
    var questions = []
    var questionTitle : String = ""
    var currentQuestion : Int = 0
    var usersAnswer : String = ""
    var answer : String = ""
    var totalCorrect : Int = 0
    var correct : Bool = false
    
    @IBOutlet weak var question: UILabel!
    
    @IBOutlet weak var rightAnswer: UILabel!
    
    @IBOutlet weak var userAnswer: UILabel!

    
    override func viewDidLoad() {
        if(correct == true) {
            userAnswer.text = "Correct!"
            totalCorrect = totalCorrect + 1
        } else {
            userAnswer.text = "Wrong!"
        }
        question.text = questionTitle
        rightAnswer.text = "The right answer is: " + usersAnswer
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func next(sender: AnyObject) {
        if (questions != "" ) {
            let nextQuestionView = self.storyboard!.instantiateViewControllerWithIdentifier("questionView") as! QuestionViewController
            nextQuestionView.totalCorrect = totalCorrect
            nextQuestionView.currentQuestion = currentQuestion + 1
            nextQuestionView.questions = self.questions
            self.presentViewController(nextQuestionView, animated: false, completion: nil)
        } else {
            let nextQuestionView = self.storyboard!.instantiateViewControllerWithIdentifier("resultsView") as! ResultsViewController
            nextQuestionView.totalCorrect = totalCorrect
            nextQuestionView.currentQuestion = currentQuestion + 1
            self.presentViewController(nextQuestionView, animated: false, completion: nil)
        }
    }
    
}