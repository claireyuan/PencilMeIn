//
//  SettingsViewController.swift
//  PencilMeIn
//
//  Created by Claire Yuan on 9/12/15.
//  Copyright (c) 2015 PencilMeIn. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
     // MARK: Properties
    @IBOutlet weak var businessNameTextField: UITextField!
    @IBOutlet weak var keyWordsTextField: UITextField!
    
    var business: Business!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Business.getFromServer { (object) -> Void in
            if let business = object {
                // we have a business
                self.businessNameTextField.text = business.name
                self.business = business
                var keyWordsString: String = ""
                
                for keyword in business.keywords {
                    keyWordsString = keyWordsString + (keyword as! String) + ", "
                }
                self.keyWordsTextField.text = keyWordsString
                
            } else {
                // we don't :(
                self.business = Business.createBusiness("Test Business", keywords: NSArray(array: ["placeholder", "professional", "fun"]), address: "This be the address")
                
                self.businessNameTextField.text = self.business.name
                var keyWordsString: String = ""
                
                for keyword in self.business.keywords {
                    keyWordsString = keyWordsString + (keyword as! String) + ", "
                }
                self.keyWordsTextField.text = keyWordsString
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveClicked(sender: UIBarButtonItem) {
        
        // Check legitimacy of business name
        if businessNameTextField.text == "" {
            var alert = UIAlertController(title: "Must input business name", message: "Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                }))
            
            presentViewController(alert, animated: true, completion: nil)
        } else {
            business.name = businessNameTextField.text
        }

        // tokenize keywords
        if keyWordsTextField.text == "" {
            var alert = UIAlertController(title: "Must input keywords", message: "Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
                
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                }))
                
            presentViewController(alert, animated: true, completion: nil)
        } else {
            var keyWords: [String] = keyWordsTextField.text.componentsSeparatedByString(",")
            
            var i = 0
            while i < keyWords.count {
                keyWords[i] = keyWords[i].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
                i++
            }
            business.keywords = keyWords
        }
        
        keyWordsTextField.resignFirstResponder()
        businessNameTextField.resignFirstResponder()
        
        business.putToServer { (object) -> Void in
        }
        
    }
    
    @IBAction func undoClicked(sender: UIBarButtonItem) {
        viewDidLoad()
    }
}

