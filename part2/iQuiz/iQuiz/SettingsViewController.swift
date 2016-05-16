//
//  SettingsViewController.swift
//  iQuiz
//
//  Created by Kevin Ke on 5/16/16.
//  Copyright © 2016 Kevin Ke. All rights reserved.
//

import UIKit
import Foundation

class SettingsViewController: UIViewController {
    
    var jsonData: [AnyObject] = []
    
    override func viewDidLoad() {
        self.url.text = "http://tednewardsandbox.site44.com/questions.json"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var url: UITextField!
    
    
    @IBAction func changeFile(sender: AnyObject) {
        let requestURL: NSURL = NSURL(string: self.url.text!)!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession();
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse : NSHTTPURLResponse
            if response != nil {
                httpResponse = response as! NSHTTPURLResponse
                let statusCode = httpResponse.statusCode
                
                if statusCode == 200 {
                    do {
                        
                        self.jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! [AnyObject]
                        
                    } catch {
                        print("Error with Json: \(error)")
                    }
                }
            }
        }
        
        task.resume()
    }
    
    @IBAction func exit(sender: AnyObject) {
        let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        viewController.jsonData = jsonData
        self.presentViewController(viewController, animated: true, completion: nil)

    }

}
