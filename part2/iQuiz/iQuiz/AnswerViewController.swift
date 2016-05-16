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
    var questionList : [String] = []
    var currentQuestion : Int = 0
    var correctAnswer : String = ""
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
        question.text = questionList[currentQuestion - 1]
        rightAnswer.text = "The right answer is: " + correctAnswer
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func next(sender: AnyObject) {
        if (currentQuestion < questionList.count) {
            self.performSegueWithIdentifier("showQuestionView", sender: nil)
        } else {
            self.performSegueWithIdentifier("showResultsView", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (currentQuestion < questionList.count) {
            let nextQuestionView = segue.destinationViewController as! QuestionViewController
            nextQuestionView.totalCorrect = totalCorrect
            nextQuestionView.currentQuestion = currentQuestion
            nextQuestionView.questions = questions
        } else {
            let nextQuestionView = segue.destinationViewController as! ResultsViewController
            nextQuestionView.totalCorrect = totalCorrect
            nextQuestionView.currentQuestion = currentQuestion
        }

    }
    
}