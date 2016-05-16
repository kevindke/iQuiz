//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Kevin Ke on 5/12/16.
//  Copyright © 2016 Kevin Ke. All rights reserved.
//

import UIKit
import Foundation


class QuestionViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var questionText: UILabel!

    var questions = []
    var questionList : [String] = []
    var currentQuestion: Int = 0
    var options : [[AnyObject]] = []
    var selectedAnswer: String = ""
    var rightAnswers : [String] = []
    var totalCorrect: Int = 0
    
    
    override func viewDidLoad() {
        for question in questions {
            let title = question["text"] as! String
            questionList.append(title)
            
            let choices = question["answers"] as! [AnyObject]
            options.append(choices)
            
            let answer = question["answer"] as! String
            rightAnswers.append(answer)
        }
        let possibleAnswers = options[currentQuestion] as! NSArray
        print(possibleAnswers)
        
        questionText.text = questionList[currentQuestion]
        button1.setTitle((possibleAnswers[0] as? String), forState: UIControlState.Normal)
        button2.setTitle((possibleAnswers[1] as? String), forState: UIControlState.Normal)
        button3.setTitle((possibleAnswers[2] as? String), forState: UIControlState.Normal)
        button4.setTitle((possibleAnswers[3] as? String), forState: UIControlState.Normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func submit(sender: AnyObject) {
        let answerViewController = self.storyboard!.instantiateViewControllerWithIdentifier("answerView") as! AnswerViewController
        if (selectedAnswer == rightAnswers[currentQuestion]) {
            answerViewController.correct = true
            totalCorrect = totalCorrect + 1
            answerViewController.totalCorrect = totalCorrect
        } else {
            answerViewController.correct = false
        }
        self.presentViewController(answerViewController, animated: false, completion: nil)

    }
    
    @IBAction func button1(sender: AnyObject) {
        selectedAnswer = "1"
    }
    
    @IBAction func button2(sender: AnyObject) {
        selectedAnswer = "2"
    }
    
    @IBAction func button3(sender: AnyObject) {
        selectedAnswer = "3"
    }
    
    @IBAction func button4(sender: AnyObject) {
        selectedAnswer = "4"
    }
    
    
    @IBAction func back(sender: AnyObject) {
        let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
    }

}