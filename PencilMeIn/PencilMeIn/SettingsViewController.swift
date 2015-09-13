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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func businessNameChanged(sender: UITextField) {
        var businessName: String = sender.text
        
        if businessName == "" {
            var alert = UIAlertController(title: "Must input business name", message: "Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                sender.text = ""
            }))
            
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func keyWordsEdited(sender: UITextField) {
        var keyWords: [String] = sender.text.componentsSeparatedByString(",")
        
        var i = 0
        while i < keyWords.count {
            keyWords[i] = keyWords[i].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        }
    }
    
    @IBAction func rescheduleNumberChanged(sender: UISlider) {
    }
    
    @IBAction func rescheduleTimeLimitChanged(sender: UISlider) {
    }
}

