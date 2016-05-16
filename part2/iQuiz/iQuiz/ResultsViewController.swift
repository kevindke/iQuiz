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
            results.text = "All right!"
        case 0:
            results.text = "You got none right."
        default:
            results.text = "You got " + String(self.totalCorrect) + " out of " + String(self.currentQuestion)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}