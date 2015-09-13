//
//  CustomerSettingsViewController.swift
//  PencilMeIn
//
//  Created by Claire Yuan on 9/12/15.
//  Copyright © 2015 PencilMeIn. All rights reserved.
//

import UIKit

class CustomerSettingsViewController: UIViewController {
    
    @IBAction func fullNameEntered(sender: UITextField) {
        var fullName: String = sender.text
        
        var containsSpace: Bool = false
        for character in fullName {
            if character == " " {
                containsSpace = true
            }
        }
        
        if !containsSpace {
            var alert = UIAlertController(title: "Please enter first and last name", message: "Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                sender.text = ""
            }))
            
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func emailEntered(sender: UITextField) {
        var email: String = sender.text
        
        let emailCheck: [Character] = ["@","."]
        var i = 0
        for character in email {
            if i < emailCheck.count && character == emailCheck[i] {
                i++
            }
        }
        
        if i < emailCheck.count {
            var alert = UIAlertController(title: "Invalid Email Address", message: "Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                sender.text = ""
            }))
            
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func phoneEntered(sender: UITextField) {
        var phone: String = sender.text
        if (NSString(string: phone).length != 10) {
            var alert = UIAlertController(title: "Invalid Phone Number", message: "Please enter 10 digits.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
               sender.text = ""
            }))
            
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

