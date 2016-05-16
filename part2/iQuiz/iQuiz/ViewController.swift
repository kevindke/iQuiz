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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        retrieveOnline("http://tednewardsandbox.site44.com/questions.json")
        
    }
    
    private func retrieveOnline(getUrl : String) {
        let getURL: NSURL = NSURL(string: "http://tednewardsandbox.site44.com/questions.json")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: getURL)
        getHTTP(urlRequest) { (data, error) -> Void in
            if error != nil {
                print("httpGet error:")
                print(error)
            } else {
                let jsonData = data.dataUsingEncoding(NSUTF8StringEncoding);
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .AllowFragments)
                    if let jsonObject = (json as? NSArray){
                        var i = 0;
                        for quiz in jsonObject {
                            let title = quiz["title"] as! String;
                            print(self.categories[i])
                            self.categories[i] = title;
                            let description = quiz["desc"] as! String;
                            self.categoryDescriptions[i] = description;
                            switch title {
                            case "Science!":
                                self.scienceQuestions = quiz["questions"] as! [AnyObject]
                            case "Marvel Super Heroes":
                                self.marvelQuestions = quiz["questions"] as! [AnyObject]
                            case "Mathematics":
                                self.mathQuestions = quiz["questions"] as! [AnyObject]
                            default:
                                print("data retrieve error: cannot find quizzes");
                            }
                            i = i+1;
                        }
                    }
                    print(json)
                    print(self.scienceQuestions)
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
    }
    
    func getHTTP(request: NSURLRequest!, callback: (String, String?) -> Void) {
        let session = NSURLSession.sharedSession();
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in if error != nil {
                callback("", error!.localizedDescription)
            } else {
                let result = NSString(data: data!, encoding: NSASCIIStringEncoding)!;
                callback(result as String, nil)
            }
        }
        task.resume()
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
        print(indexPath.row)
        cell.photo.image = images[indexPath.row]
        cell.category.text = categories[indexPath.row]
        cell.subtitle.text = categoryDescriptions[indexPath.row]
        return cell
    }
    
    var selectedQuiz: [Array<String>] = []
    var selectedQuestions: [NSDictionary] = []
    
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
        let alert = UIAlertController(title: "Settings", message: "settings will go here", preferredStyle:UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

