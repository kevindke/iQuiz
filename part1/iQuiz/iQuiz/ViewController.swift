//
//  ViewController.swift
//  iQuiz
//
//  Created by Kevin Ke on 5/4/16.
//  Copyright © 2016 Kevin Ke. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let categories = ["Marvel", "Mathematics", "Science"]
    let categoryDescriptions = ["Marvel universe including heroes, villians, etc.", "Covers simple algebra", "Covers biology and chemistry"]
    let images = [UIImage(named: "marvel"), UIImage(named: "calc"), UIImage(named: "flask")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        
        cell.photo.image = images[indexPath.row]
        cell.category.text = categories[indexPath.row]
        cell.subtitle.text = categoryDescriptions[indexPath.row]
        
        return cell
    }

    @IBAction func settingsButton(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Settings", message: "settings will go here", preferredStyle:UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

