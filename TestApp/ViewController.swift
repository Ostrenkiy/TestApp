//
//  ViewController.swift
//  TestApp
//
//  Created by Alexander Karpov on 25.02.15.
//  Copyright (c) 2015 Alex Karpov. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Alamofire_SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var detailsButton: UIButton!
    
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var downloadedJSONArray = [JSON]()
    
    /**
    Function for downloading the JSON file and saving it to an array.
    */
    func downloadJSON() {
        Alamofire.request(.GET, "http://test.binaryblitz.ru/users.json")
            .responseSwiftyJSON { (_, _, json, error) -> Void in
                if error == nil {
                    self.downloadedJSONArray = json.arrayValue
                    self.tableView.reloadData()
                    self.detailsButton.enabled = false
                } else {
                    println(error)
                }
        }
    }
    
    /**
    Registers the device by sending POST request
    */
    func registerDevice() {
        let deviceParameters = [ 
            "upload" : [
                "imei" : "990000862471854",
                "message" : "hello world"
                ]
        ]
        
        
        Alamofire.request(.POST, "http://test.binaryblitz.ru/uploads", parameters : deviceParameters, encoding: .JSON).responseSwiftyJSON {(_, httpResponse, json, error) -> Void in
            println(httpResponse?.statusCode)
            if httpResponse?.statusCode == 201 {
                println("created")
            } else {
                println(httpResponse?.accessibilityElements)
                println("error")
                println(json)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if defaults.valueForKey("did start") == nil {
            registerDevice()
        } else {
            defaults.setValue("true", forKey: "did start")
        }
        //downloadJSON()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showDetailsButtonPressed(sender: AnyObject) {
        if tableView.indexPathForSelectedRow() != nil {
            println(tableView.indexPathForSelectedRow())
            performSegueWithIdentifier("show detail", sender: self)
        }
    }
    
    @IBAction func fetchButtonPressed(sender: AnyObject) {
        downloadJSON()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "show detail") {
            let detailVC = segue.destinationViewController as DetailViewController
            detailVC.userID = downloadedJSONArray[tableView.indexPathForSelectedRow()!.row].dictionaryObject!["id"] as Int
        }
    }
}

extension ViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return downloadedJSONArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCellWithIdentifier("name cell") as NameTableViewCell
        
        let name = downloadedJSONArray[indexPath.row].dictionaryObject!["name"] as? String
        let surname = downloadedJSONArray[indexPath.row].dictionaryObject!["surname"] as? String
        if (name == nil || surname == nil) {
            cell.nameLabel.text = ""
        } else {
            cell.nameLabel.text = name! + " " + surname!
        }
        
        return cell
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        detailsButton.enabled = true
    }

    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        detailsButton.enabled = false
    }
}
