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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        businessNameTextField.text = getNameFromServer()
//        var keyWordsString: String
//        for keyword in getKeywordArrayFromServer() {
//            keyWordsString = keyWordsString + keyword + ", "
//        }
//        keyWordsTextField.text = keyWordsString
        
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
            }
        }
        
        keyWordsTextField.resignFirstResponder()
        businessNameTextField.resignFirstResponder()
        
        // TODO: send to server
        
    }
    
    @IBAction func undoClicked(sender: UIBarButtonItem) {
        viewDidLoad()
    }
}

