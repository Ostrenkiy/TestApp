//
//  DetailViewController.swift
//  TestApp
//
//  Created by Alexander Karpov on 25.02.15.
//  Copyright (c) 2015 Alex Karpov. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Alamofire_SwiftyJSON

class DetailViewController: UIViewController {

    var userID = Int()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var infoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "id: \(userID)"
        downloadJSON()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
    Function for downloading the JSON file and saving it to an array.
    */
    func downloadJSON() {
        Alamofire.request(.GET, "http://test.binaryblitz.ru/users/\(userID).json")
            .responseSwiftyJSON { (_, _, json, error) -> Void in
                if error == nil {
                    println(json)
                    //self.downloadedJSON = json
                    self.reload(json)
                } else {
                    println(error)
                }
        }
    }
    
    func reload(json: JSON) {
        self.infoTextView.text = json.dictionaryObject!["info"] as? String
        self.nameLabel.text = "Name: " + (json.dictionaryObject!["name"] as String)
        self.surnameLabel.text = "Surname: " + (json.dictionaryObject!["surname"] as String)
        self.createdLabel.text = "Created at: " + (json.dictionaryObject!["created_at"] as String)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
