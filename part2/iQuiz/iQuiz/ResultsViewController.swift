//
//  ResultsViewController.swift
//  iQuiz
//
//  Created by Kevin Ke on 5/15/16.
//  Copyright © 2016 Kevin Ke. All rights reserved.
//

import UIKit
import Foundation

class ResultsViewController: UIViewController {
    
    var totalCorrect : Int = 0
    var currentQuestion : Int = 0
    
    @IBOutlet weak var results: UILabel!
    
    override func viewDidLoad() {
        switch self.totalCorrect {
        case self.currentQuestion:
            results.text = "One hundred percent!"
        case 0:
            results.text = "You got none right"
        default:
            results.text = "You got " + String(totalCorrect) + " out of " + String(currentQuestion)
        }
    }
    
    @IBAction func back(sender: AnyObject) {
        self.performSegueWithIdentifier("showView", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}