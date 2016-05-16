//
//  ViewController.swift
//  iQuiz
//
//  Created by Kevin Ke on 5/4/16.
//  Copyright © 2016 Kevin Ke. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var categories: [String] = ["Science", "Marvel Super Heroes", "Mathematics"]
    var categoryDescriptions: [String] = ["", "", ""]
    var images = [UIImage(named: "flask"), UIImage(named: "marvel"), UIImage(named: "calc")]
    
    var mathQuestions = []
    var scienceQuestions = []
    var marvelQuestions = []
    var jsonData: [AnyObject] = []
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        fetchData()
        
    }
    
    func fetchData() {
        let requestURL: NSURL = NSURL(string: "http://tednewardsandbox.site44.com/questions.json")!
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
                        self.defaults.setObject(self.jsonData, forKey: "currentJSON")
                        self.processJSON(self.jsonData)

                    } catch {
                        print("Error with Json: \(error)")
                    }
                    
                } else {
                    self.retrieveBackupJSON()
                }
            }
        }
        
        task.resume()
    }
    
    func processJSON(json: AnyObject) {
        if let jsonObject = (json as? NSArray){
            for var i = 0; i < jsonObject.count; i++ {
                let title = jsonObject[i]["title"] as! String;
                self.categories[i] = title;
                let description = jsonObject[i]["desc"] as! String;
                self.categoryDescriptions[i] = description;
                switch title {
                case "Science!":
                    self.scienceQuestions = jsonObject[i]["questions"] as! [AnyObject]
                case "Marvel Super Heroes":
                    self.marvelQuestions = jsonObject[i]["questions"] as! [AnyObject]
                case "Mathematics":
                    self.mathQuestions = jsonObject[i]["questions"] as! [AnyObject]
                default:
                    print("Data retrieve error: cannot find quizzes");
                }
            }
        }
    }
    
    func retrieveBackupJSON() {
        print("hi")
        let path = NSBundle.mainBundle().pathForResource("backup", ofType: "json")
        let contentsOfLocalJSON = NSData.init(contentsOfFile: path!)
        do{
            
            let json = try NSJSONSerialization.JSONObjectWithData(contentsOfLocalJSON!, options: .AllowFragments) as? NSArray
            
            self.defaults.setObject(json, forKey: "currentJSON")
            self.processJSON(json!)
            
            
        }catch {
            print("Error retrieving JSON file")
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        cell.photo.image = images[indexPath.row]
        cell.category.text = categories[indexPath.row]
        cell.subtitle.text = categoryDescriptions[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let secondViewController = self.storyboard!.instantiateViewControllerWithIdentifier("questionView") as! QuestionViewController
        let quizNum = indexPath.row
        switch quizNum {
        case 0:
            secondViewController.questions = scienceQuestions 
        case 1:
            secondViewController.questions = marvelQuestions
        case 2:
            secondViewController.questions = mathQuestions
        default:
            print("cannot find questions for quizzes")
        }
        secondViewController.currentQuestion = 0
        self.presentViewController(secondViewController, animated: true, completion: nil)
    }
    
    @IBAction func settingsButton(sender: UIBarButtonItem) {
        let settingsViewController = self.storyboard!.instantiateViewControllerWithIdentifier("settingsView") as! SettingsViewController
        self.presentViewController(settingsViewController, animated: true, completion: nil)
    }
}

